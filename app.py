from flask import Flask, flash, render_template, request, session, redirect, url_for, current_app
from werkzeug.utils import secure_filename
from sqlalchemy.sql.expression import func, select
import os
import json
from passlib.hash import pbkdf2_sha256
from datetime import datetime
import secrets
import sqlite3
from models import *


with open('config.json', 'r') as c:
    params = json.load(c)["params"]

basedir = os.path.abspath(os.path.dirname(__file__))
app = Flask(__name__)
db = SQLAlchemy()
app.config['WTF_CSRF_SECRET_KEY'] = "b'f\xfa\x8b{X\x8b\x9eM\x83l\x19\xad\x84\x08\xaa"
app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:@localhost:3306/tms"
app.config['SECRET_KEY'] = "b'f\xfa\x8b{X\x8b\x9eM\x83l\x19\xad\x84\x08\xaa"
app.config['UPLOAD_FOLDER'] = os.path.join(basedir, 'static\\packimages\\')
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False


# Initialize
db.init_app(app)

def save_images(photo):
    hash_photo= secrets.token_urlsafe(20)
    _, file_extension = os.path.splitext(photo.filename)
    photo_name= hash_photo + file_extension
    file_path= os.path.join(current_app.root_path, app.config['UPLOAD_FOLDER'], photo_name)
    photo.save(file_path)
    return photo_name

@app.route("/")
def home():
    packs = Tbltourpackages.query.order_by(Tbltourpackages.Creationdate.desc()).all()
    random = Tbltourpackages.query.order_by(func.random()).all()
    return render_template('index.html', packs=packs, random=random)


@app.route("/trips-list")
def trips():
    packs = Tbltourpackages.query.order_by(Tbltourpackages.Creationdate.desc()).all()
    random = Tbltourpackages.query.order_by(func.random()).all()
    return render_template('package-list.html', packs=packs, random=random)


@app.route("/contact-us")
def contact():
    packs = Tbltourpackages.query.order_by(Tbltourpackages.Creationdate.desc()).all()
    random = Tbltourpackages.query.order_by(func.random()).all()
    return render_template('contact.html', packs=packs, random=random)

@app.route("/trip_id=<id>" , methods=['POST','GET'])
def booking(id):
    result = db.session.query(Tbltourpackages).filter(Tbltourpackages.PackageId==id).first()
    usr= db.session.query(User).filter(User.id==session.get('uid')).first()
    if result:
        if request.method == 'POST':
            if session.get('user'):
                city= request.form.get('city')
                date= request.form.get('date')
                msg= request.form.get('message')
                bk= Tblbooking(PackageId=id, UserId=session.get('uid'), city=city, FromDate=date, Comment=msg, status='3')
                db.session.add(bk)
                db.session.commit()
                flash('Your Trip is Submitted')
                return redirect(url_for('booking_history'))
            else:
                return redirect(url_for('signin'))
        else:
            return render_template('booking-page.html',  result=result, usr=usr)
    else:
        return render_template('404.html')

@app.route("/new-admin", methods=['POST','GET'])
def new_admin():
    if request.method == 'POST':
        username = request.form.get('username').lower().replace(" ","")
        email = request.form.get('email')
        passw = request.form.get('password')
        password = pbkdf2_sha256.hash(passw)
        cur= Admin.query.filter_by(username=username).first()
        if cur is None:
            admin= Admin(username=username,email=email,password=password)
            db.session.add(admin)
            db.session.commit()
            flash("NEW MODERATOR ADDED")
            return render_template("admin/pages-register.html")
        else:
            error = 'username already exist choose another!'
            return render_template("admin/pages-register.html", error=error)
    else:
        return render_template("admin/pages-register.html")

# USER SIGNUP
@app.route("/signup", methods=['POST','GET'])
def signup():
    if session.get('user'):
        return redirect(url_for('user'))
    else:
        if request.method == 'POST':
            fullname = request.form.get('fullname')
            email = request.form.get('email')
            mobile = request.form.get('mobile')
            passw = request.form.get('password')
            password = pbkdf2_sha256.hash(passw)
            cur= User.query.filter_by(email=email).first()
            if cur is None:
                usr= User(fullname=fullname,email=email, mobile=mobile ,password=password)
                db.session.add(usr)
                db.session.commit()
                return redirect(url_for('signin'))
            else:
                error = 'username already exist choose another!'
                return render_template("user/pages-register.html", error=error)
        else:
            return render_template("user/pages-register.html")


# ADMIN LOGIN
@app.route("/admin" , methods=['POST','GET'])
def login():
     if session.get('admin'):
         return redirect(url_for('admin'))
     elif session.get('user'):
         session.clear()
         return render_template("admin/pages-login.html")
     else:
         if request.method == "POST":
            username = request.form.get("username")
            password = request.form.get("password")
            adm = Admin.query.filter_by(username=username).first()
            if pbkdf2_sha256.verify(password, adm.password):
                session['admin'] = adm.username
                session['aid']= adm.id
                return redirect(url_for('admin'))
            else:
                error='Invalid Username or Password'
                return render_template("admin/pages-login.html", error=error)
         else:
             return render_template("admin/pages-login.html")


# User Login Page
@app.route("/login" , methods=['POST','GET'])
def signin():
     if session.get('user'):
         return redirect(url_for('user'))
     elif session.get('admin'):
         session.clear()
         return render_template("user/pages-login.html")
     else:
         if request.method == "POST":
            email = request.form.get("email")
            password = request.form.get("password")
            usr = User.query.filter_by(email=email).first()
            if pbkdf2_sha256.verify(password, usr.password):
                session['user'] = usr.email
                session['uid']= usr.id
                session['username']= usr.fullname
                return redirect(url_for('user'))
            else:
                error='Invalid Username or Password'
                return render_template("user/pages-login.html", error=error)
         else:
             return render_template("user/pages-login.html")

# USER DASHBOARD
@app.route("/user_dashboard")
def user():
    if session.get('user'):
        return render_template("user/user.html")
    else:
        flash('LOGIN FIRST TO ACCESS DASHBOARD')
        return redirect(url_for('signin'))


#  ADMIN DASHBOARD
@app.route("/dashboard")
def admin():
    if session.get('admin'):
        member=User.query.count()
        cats = Tbltourpackages.query.all()
        booking = db.session.query(User, Tblbooking, Tbltourpackages).filter(Tblbooking.UserId == User.id).filter(
            Tblbooking.PackageId == Tbltourpackages.PackageId) \
            .order_by(Tblbooking.RegDate.desc()).all()
        msg= db.session.query(Chat,User).filter(Chat.uid==User.id).filter(Chat.sender>1).order_by(Chat.time.desc()).all()
        return render_template("admin/admin.html",cats=cats, member=member, booking=booking, msg=msg)
    else:
        flash('LOGIN FIRST TO ACCESS DASHBOARD')
        return redirect(url_for('login'))

# ADMIN ADD NEW TOUR
@app.route("/add-tour", methods=['POST','GET'])
def add_tour():
    if session.get('admin'):
        if request.method == 'POST':
            title = request.form.get('title')
            location = request.form.get('location')
            transport = request.form.get('transport')
            meal = request.form.get('meal')
            accommodation = request.form.get('accommodation')
            duration = request.form.get('duration')
            pdetails = request.form.get('editor')
            price = request.form.get('price')
            f = save_images(request.files.get('timage'))
            flash("THIS ARTICLE HAS BEEN PUBLISHED")
            tour = Tbltourpackages(PackageName=title, PackageDetails=pdetails, PackageLocation=location, Transport=transport, Meal=meal,Duration=duration,
                                   Accommodation=accommodation,PackagePrice=price, PackageImage =f)
            db.session.add(tour)
            db.session.commit()
            return redirect(url_for('admin'))
        else:
            return render_template("admin/add-tour.html")

    else:
        flash('LOGIN FIRST TO PROCEED')
        return render_template("admin/pages-login.html")


#  EDIT TOUR INFORMATION
@app.route("/manage-tour/id=<id>/action=edit", methods=['POST', 'GET'])
def edit_tour(id):
    if session.get('admin'):
        if request.method == 'POST':
            img= request.files.get('timage')
            title = request.form.get('title')
            location = request.form.get('location')
            transport = request.form.get('transport')
            meal = request.form.get('meal')
            accommodation = request.form.get('accommodation')
            duration = request.form.get('duration')
            tdetails = request.form.get('editor')
            price = request.form.get('price')
            hello= Tbltourpackages.query.filter_by(PackageId=id).first()
            _, file_extension = os.path.splitext(img.filename)
            if ('.jpg' or '.jpeg' or '.png') in file_extension:
                updte = db.session.query(Tbltourpackages).filter_by(PackageId=id).first()
                os.remove(app.config['UPLOAD_FOLDER']+updte.PackageImage)
                updte.PackageName = title
                updte.PackageLocation = location
                updte.PackageImage = save_images(request.files.get('timage'))
                updte.Transport = transport
                updte.Meal = meal
                updte.Accommodation = accommodation
                updte.Duration = duration
                updte.PackagePrice = price
                updte.PackageDetails = tdetails
                db.session.commit()
                flash("CHANGES WERE MADE SUCCESSFULLY")
                return redirect(url_for('manage_tours'))
            else:
                updte = db.session.query(Tbltourpackages).filter_by(PackageId=id).first()
                updte.PackageName = title
                updte.PackageLocation = location
                updte.PackageImage = hello.PackageImage
                updte.Transport = transport
                updte.Meal = meal
                updte.Accommodation = accommodation
                updte.Duration = duration
                updte.PackagePrice = price
                updte.PackageDetails = tdetails
                db.session.commit()
                flash("POST AS BEEN UPDATED")
                return redirect(url_for('manage_tours'))
        else:
            t = db.session.query(Tbltourpackages).filter(Tbltourpackages.PackageId==id).first()
            if t:
                return render_template("admin/edit-tour.html", id=id,t=t)
            else:
                return render_template('404.html')
    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('login'))


#  DELETE A TOUR PACKAGE
@app.route("/edit-tour/action_delete=<int:id>", methods=['POST','GET'])
def delete_pack(id):
    if session.get('admin'):
        post = db.session.query(Tbltourpackages).filter_by(PackageId=id).first()
        if post is None:
            flash("This Item is Already Deleted")
            return redirect(url_for('manage_tours'))
        else:
            record= db.session.query(Tbltourpackages).filter_by(PackageId=id).first()
            os.remove(app.config['UPLOAD_FOLDER']+record.PackageImage)
            db.session.delete(record)
            db.session.commit()
            flash('Package Has been Deleted')
            return redirect(url_for('manage_tours'))
    else:
        flash('LOGIN FIRST TO PROCEED')
        return render_template("admin/pages-login.html")


#  MANAGE BOOKINGS
@app.route("/manage-bookings",  methods=['POST','GET'])
def manage_bookings():
    if session.get('admin'):
        if request.method == 'POST':
            st = request.form.get('myselect')
            bkid= request.form.get('bkid')
            bk = db.session.query(Tblbooking).filter_by(BookingId=bkid).first()
            bk.status = st
            db.session.commit()
            return redirect(request.url)
        else:
            booking = db.session.query(User, Tblbooking, Tbltourpackages).filter(Tblbooking.UserId==User.id).filter(Tblbooking.PackageId==Tbltourpackages.PackageId)\
            .order_by(Tblbooking.RegDate.desc()).all()
            return render_template("admin/bookings.html",booking=booking)
    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('login'))


#   MANAGE TOURS
@app.route("/manage-tours")
def manage_tours():
    if session.get('admin'):
        tours = db.session.query(Tbltourpackages).order_by(Tbltourpackages.Creationdate.desc()).all()

        return render_template("admin/manage-packages.html",tours=tours)
    else:
        flash('LOGIN FIRST TO PROCEED')
        return render_template("admin/pages-login.html")

#   GUEST USER CONTACT HELP
@app.route("/manage-help",  methods=['POST','GET'])
def guest_help():
    if session.get('admin'):
        if request.method == 'POST':
            id= request.form.get('eqid')
            st= request.form.get('st')
            stats = db.session.query(TblEnquiry).filter_by(id=id).first()
            stats.Status = st
            db.session.commit()
            return redirect(request.url)
        else:
            msg = TblEnquiry.query.order_by(TblEnquiry.PostingDate.desc()).all()
            return render_template("admin/guest-help.html",msg=msg)
    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('login'))

#    MANAGE USERS
@app.route("/manage-users")
def manage_users():
    if session.get('admin'):
        users = User.query.order_by(User.regdate.desc()).all()

        return render_template("admin/manage-users.html",users=users)
    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('login'))

#    USER BOOKING HISTORY
@app.route("/booking-history")
def booking_history():
    if session.get('user'):
        b = db.session.query(Tblbooking,Tbltourpackages).filter(Tblbooking.UserId==session.get('uid')).filter(Tblbooking.PackageId==Tbltourpackages.PackageId)\
            .order_by(Tblbooking.RegDate.desc()).all()

        return render_template("user/booking-history.html",b=b)
    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('user'))

# User Chat Screen
@app.route("/chat" , methods=['POST','GET'])
def uchat():
    if session.get('user'):
        if request.method == 'POST':
            msg = request.form.get('msg')
            cht = Chat(uid=session.get('uid'), message=msg, sender=session.get('uid'), status='2')
            db.session.add(cht)
            db.session.commit()
            return redirect(request.url)
        else:
            result = db.session.query(Chat,User).filter(Chat.uid==session.get('uid')).filter(User.id==session.get('uid')).order_by(Chat.time).all()
            user= About.query.filter(About.id==1).first()
            return render_template("user/apps-chat.html",user=user, result=result)

    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('signin'))

# ADMIN CHAT SCREEN
@app.route("/chat=<uid>" , methods=['POST','GET'])
def chat(uid):
    if session.get('admin'):
        if request.method == 'POST':
            msg = request.form.get('msg')
            cht = Chat(uid=uid, message=msg, sender=session.get('aid'), status='1')
            db.session.add(cht)
            db.session.commit()
            return redirect(request.url)
        else:
            result = Chat.query.filter(Chat.uid==uid).order_by(Chat.time).all()
            user= User.query.filter(User.id==uid).first()
            if user:
                return render_template("admin/apps-chat.html",user=user, result=result, uid=uid)
            else:
                return render_template('404.html')

    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('login'))

# ADMIN CONTACT HELP NOTIFICATIONS
@app.route("/help", methods=['POST','GET'])
def help():
    if session.get('admin'):
        if request.method == 'POST':
            status = request.form.get('read')
            uid = request.form.get('usr')
            cht = request.form.get('cht')
            ch= db.session.query(Chat).filter_by(id=cht).first()
            ch.status=status
            db.session.commit()
            return redirect("../chat="+uid)
        else:
            u = User.query.all()
            r = db.session.query(Chat, User).filter(User.id==Chat.uid).order_by(Chat.time.desc()).all()
            return render_template("admin/chat.html", u=u, r=r)
    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('login'))


#    EDIT PAGE TYPES
@app.route("/page_type=<type>", methods=['POST','GET'])
def pges(type):
    if session.get('admin'):
        if request.method == 'POST':
            detail = request.form.get('editor')
            typ= db.session.query(Tblpages).filter_by(type=type).first()
            typ.detail=detail
            db.session.commit()
            return redirect('page_type='+type)
        else:
            t = db.session.query(Tblpages).filter_by(type=type).first()
            if t:
                return render_template("admin/pages.html", t=t)
            else:
                return render_template('404.html')
    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('login'))


#  EDIT CONTACT INFO
@app.route("/edit-contact", methods=['POST','GET'])
def edit_contact():
    if session.get('admin'):
        if request.method == 'POST':
            aid = request.form.get('aid')
            phone = request.form.get('phone')
            email = request.form.get('email')
            abt= db.session.query(About).filter_by(id=aid).first()
            abt.email=email
            abt.phone=phone
            db.session.commit()
            return redirect(request.url)
        else:
            a= db.session.query(About).filter_by(id=1).first()
            return render_template("admin/edit-contact.html", a=a)
    else:
        flash('LOGIN FIRST TO PROCEED')
        return redirect(url_for('login'))


#  Guest contact(enquiry) Page
@app.route("/contact-us", methods=['POST','GET'])
def contact_us():
    if request.method == 'POST':
        fullname = request.form.get('fname')
        phone = request.form.get('phone')
        email = request.form.get('email')
        subject = request.form.get('subject')
        description = request.form.get('msg')
        enq= TblEnquiry(FullName=fullname, EmailId=email, MobileNumber=phone, Subject=subject, Description=description, Status='2')
        db.session.add(enq)
        db.session.commit()
        flash('MESSAGE HAS BEEN SENT')
        return redirect(request.url)
    else:
        ct= db.session.query(Tbltourpackages).filter_by(id=1).first()
        print(ct.email)
        return render_template("contact.html", ct=ct)


#  GUEST USER PAGE TYPE
@app.route("/page_<type>")
def info(type):
            t = db.session.query(Tblpages).filter_by(type=type).first()
            if t:
                return render_template("page.html", t=t)
            else:
                return render_template('404.html')


#   PASSWORD CHANGE SECTION
@app.route("/change-password", methods=['POST','GET'])
def change_password():
    if session.get('admin'):
        if request.method=='POST':
            oldpass=request.form.get('oldpass')
            password = pbkdf2_sha256.hash(request.form.get('password'))
            adm = Admin.query.filter_by(id=session.get('aid')).first()
            if pbkdf2_sha256.verify(oldpass, adm.password):
                upt = db.session.query(Admin).filter_by(id=session.get('aid')).first()
                upt.password = password
                db.session.commit()
                flash('PASSWORD UPDATED SUCCESSFULLY')
                return render_template("admin/change-password.html")
            else:
                error='YOUR OLD PASSWORD WAS INCORRECT'
                return render_template("admin/change-password.html", error=error)
        else:
            return render_template("admin/change-password.html")
    elif session.get('user'):
        if request.method=='POST':
            oldpass=request.form.get('oldpass')
            password = pbkdf2_sha256.hash(request.form.get('password'))
            usr = User.query.filter_by(id=session.get('uid')).first()
            if pbkdf2_sha256.verify(oldpass, usr.password):
                upt = db.session.query(User).filter_by(id=session.get('uid')).first()
                upt.password = password
                db.session.commit()
                flash('PASSWORD UPDATED SUCCESSFULLY')
                return render_template("user/change-password.html")
            else:
                error='YOUR OLD PASSWORD WAS INCORRECT'
                return render_template("user/change-password.html", error=error)
        else:
            return render_template("user/change-password.html")
    else:
        flash('LOGIN FIRST TO ACCESS DASHBOARD')
        return redirect(url_for('login'))

# # HOME PAGE
# @app.route("/")
# def home():
#     # Contact US
#     contact= Tblcontact.query.all()
#     #latest 5 posts order by time
#     # Nop stands for number of posts
#     posts = Tblposts.query.order_by(Tblposts.ptime.desc()).all()
#     # random posts
#     random = Tblposts.query.order_by(func.random()).all()
#     count= Category.query.count()
#     # Fetch all category
#     posts_cat = Category.query.all()
#     return render_template('/index.html', posts=posts, random=random, contact=contact, count=count,posts_cat=posts_cat)
#
# @app.route("/read-post/<id>", methods=['GET'])
# def read_post(id):
#     result = db.session.query(Tblposts, Category).filter(Tblposts.pid == id). \
#         filter(Category.cid == Tblposts.catid).first()
#     if result:
#         # latest 5 posts order by time
#         # Nop stands for number of posts
#         posts = Tblposts.query.order_by(Tblposts.ptime.desc()).all()
#         # Nop stands for number of posts
#         random = Tblposts.query.order_by(func.random()).all()
#         # Fetch all category
#         posts_cat = Category.query.all()
#         db.session.query(Tblposts, Category, User).filter(Tblposts.catid == Category.cid). \
#             filter(Tblposts.pubid == User.id).order_by(Tblposts.ptime.desc()).all()
#         return render_template('read-post.html', posts=posts, result=result, random=random, posts_cat=posts_cat)
#     else:
#         return render_template('404.html')
#
#
#
# @app.route("/read-category/<cat>", methods=['GET'])
# def read_category(cat):
#     # Contact US
#     contact = Tblcontact.query.all()
#     # latest 5 posts order by time
#     posts = Tblposts.query.order_by(Tblposts.ptime.desc()).all()
#     # random posts
#     random = Tblposts.query.order_by(func.random()).all()
#     count = Category.query.count()
#     # Fetch all category
#     posts_cat = Category.query.all()
#     # Where clause
#     readcat =  db.session.query(Tblposts,Category).filter(Category.cname==cat).\
#         filter(Tblposts.catid==Category.cid).all()
#
#     return render_template('read-category.html',cat=cat,contact=contact, random=random, readcat=readcat,posts_cat=posts_cat, posts=posts)
#
# @app.route("/dashboard")
# def admin():
#     if session.get('admin'):
#         member=User.query.count()
#         cats = Category.query.all()
#         posts = db.session.query(Tblposts,Category).filter(Tblposts.catid==Category.cid).\
#             order_by(Tblposts.ptime.desc()).all()
#         return render_template("admin/index.html", posts=posts, cats=cats, member=member)
#     elif session.get('mod'):
#         member=User.query.count()
#         cats = Category.query.all()
#         posts = db.session.query(Tblposts,Category).filter(Tblposts.catid==Category.cid).\
#             order_by(Tblposts.ptime.desc()).all()
#         return render_template("mod/index.html", posts=posts, cats=cats, member=member)
#     else:
#         flash('LOGIN FIRST TO ACCESS DASHBOARD')
#         return redirect(url_for('login'))
#
# @app.route("/change-password", methods=['POST','GET'])
# def change_password():
#     if session.get('admin'):
#         if request.method=='POST':
#             oldpass=request.form.get('oldpass')
#             password = pbkdf2_sha256.hash(request.form.get('password'))
#             adm = Admin.query.filter_by(username=session.get('admin')).first()
#             if pbkdf2_sha256.verify(oldpass, adm.password):
#                 upt = db.session.query(Admin).filter_by(username=session.get('admin')).first()
#                 upt.password = password
#                 db.session.commit()
#                 flash('PASSWORD UPDATED SUCCESSFULLY')
#                 return render_template("admin/change-password.html")
#             else:
#                 error='YOUR OLD PASSWORD WAS INCORRECT'
#                 return render_template("admin/change-password.html", error=error)
#         else:
#             return render_template("admin/change-password.html")
#     elif session.get('mod'):
#         if request.method=='POST':
#             oldpass=request.form.get('oldpass')
#             password = pbkdf2_sha256.hash(request.form.get('password'))
#             mod = User.query.filter_by(username=session.get('mod')).first()
#             if pbkdf2_sha256.verify(oldpass, mod.password):
#                 upt = db.session.query(User).filter_by(username=session.get('mod')).first()
#                 upt.password = password
#                 db.session.commit()
#                 flash('PASSWORD UPDATED SUCCESSFULLY')
#                 return render_template("mod/change-password.html")
#             else:
#                 error='YOUR OLD PASSWORD WAS INCORRECT'
#                 return render_template("mod/change-password.html", error=error)
#         else:
#             return render_template("mod/change-password.html")
#     else:
#         flash('LOGIN FIRST TO ACCESS DASHBOARD')
#         return redirect(url_for('login'))
#
#
#
# @app.route("/add-post", methods=['POST','GET'])
# def add_post():
#     if (session.get('admin') or session.get('mod')):
#         cats = Category.query.all()
#         if request.method == 'POST':
#             pcategory = request.form.get('pcategory')
#             pheading = request.form.get('pheading')
#             pdescription = request.form.get('pdescription')
#             pdetails = request.form.get('summernote')
#             ptime = datetime.now()
#             f = save_images(request.files.get('pthumbnail'))
#             flash("THIS ARTICLE HAS BEEN PUBLISHED")
#
#             if session.get('admin'):
#                 post = Tblposts(pubid=session.get('admin'), catid=pcategory, pheading=pheading, pthumbnail=f,
#                                 pdescription=pdescription,pdetails=pdetails, ptime=ptime)
#                 db.session.add(post)
#                 db.session.commit()
#                 return render_template("admin/add-post.html", cats=cats)
#             else:
#                 post = Tblposts(pubid=session.get('mod'), catid=pcategory, pheading=pheading, pthumbnail=f,
#                                 pdescription=pdescription,
#                                 pdetails=pdetails, ptime=ptime)
#                 db.session.add(post)
#                 db.session.commit()
#                 return render_template("mod/add-post.html", cats=cats)
#         if session.get('admin'):
#             return render_template("admin/add-post.html", cats=cats)
#         else:
#             return render_template("mod/add-post.html", cats=cats)
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
#
#
# @app.route("/new-moderator", methods=['POST','GET'])
# def new_moderator():
#     if session.get('admin'):
#         if request.method == 'POST':
#             name= request.form.get('name')
#             username = request.form.get('username').lower().replace(" ","")
#             email = request.form.get('email')
#             passw = request.form.get('password')
#             password = pbkdf2_sha256.hash(passw)
#             cur= User.query.filter_by(username=username).first()
#             if cur is None:
#                 mod= User(name=name,username=username,email=email,password=password)
#                 db.session.add(mod)
#                 db.session.commit()
#                 flash("NEW MODERATOR ADDED")
#                 return render_template("admin/new-mod.html")
#             else:
#                 error = 'username already exist choose another!'
#                 return render_template("admin/new-mod.html", error=error)
#         else:
#             return render_template("admin/new-mod.html")
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
# @app.route("/update-moderator/id=<id>", methods=['POST','GET'])
# def update_moderator(id):
#     if session.get('admin'):
#         mod = User.query.filter(User.id == id).first()
#         if mod is None:
#             return redirect(url_for('new_moderator'))
#         else:
#             if request.method == 'POST':
#                 name= request.form.get('name')
#                 username = request.form.get('username').lower().replace(" ","")
#                 email = request.form.get('email')
#                 passw = request.form.get('password')
#                 password=pbkdf2_sha256.hash(passw)
#                 mod= db.session.query(User).filter(User.id==id).first()
#                 mod.name=name
#                 mod.username=username
#                 mod.email=email
#                 mod.password=password
#                 db.session.commit()
#                 flash("Informaton Updated")
#                 return render_template("admin/update-mod.html", mod=mod)
#             else:
#                 mod= User.query.filter(User.id==id).first()
#                 return render_template("admin/update-mod.html", mod=mod)
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
# @app.route("/manage-moderators")
# def view_moderators():
#     if session.get('admin'):
#         mods= User.query.all()
#         return render_template("admin/view-mod.html",mods=mods)
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
# @app.route("/update-moderator/action_delete=<id>")
# def del_moderator(id):
#     if session.get('admin'):
#         mods= db.session.query(User).all()
#         mod= db.session.query(User).filter(User.id==id).first()
#         if mod is None:
#             flash('Already Delete')
#             return redirect(url_for('view_moderators'))
#         else:
#             db.session.delete(mod)
#             db.session.commit()
#             flash('Record has been Deleted')
#             return redirect(url_for('view_moderators'))
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
#
# @app.route("/manage-posts")
# def manage_posts():
#     if session.get('admin'):
#         posts = db.session.query(Tblposts,Category).filter(Tblposts.catid==Category.cid)\
#             .order_by(Tblposts.ptime.desc()).all()
#         cats = Category.query.all()
#         return render_template("admin/manage-posts.html",cats=cats, posts=posts)
#     elif session.get('mod'):
#         posts = db.session.query(Tblposts, Category).filter(Tblposts.catid == Category.cid) \
#             .order_by(Tblposts.ptime.desc()).all()
#         cats = Category.query.all()
#         return render_template("mod/manage-posts.html",cats=cats, posts=posts)
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
#
# @app.route("/edit-post/id=<id>/action=edit", methods=['POST', 'GET'])
# def edit_post(id):
#     if session.get('admin'):
#         if request.method == 'POST':
#             thumb= request.files.get('pthumbnail')
#             pheading= request.form.get("pheading")
#             pdescription= request.form.get("pdescription")
#             pcategory= request.form.get('pcategory')
#             pdetails=request.form.get("summernote")
#             hello= Tblposts.query.filter_by(pid=id).first()
#             _, file_extension = os.path.splitext(thumb.filename)
#             if ('.jpg' or '.jpeg' or '.png') in file_extension:
#                 updte = db.session.query(Tblposts).filter_by(pid=id).first()
#                 os.remove(app.config['UPLOAD_FOLDER']+updte.pthumbnail)
#                 updte.pheading = pheading
#                 updte.pdescription = pdescription
#                 updte.pthumbnail = save_images(request.files.get('pthumbnail'))
#                 updte.catid = pcategory
#                 updte.pdetails = pdetails
#                 db.session.commit()
#                 flash("CHANGES WERE MADE SUCCESSFULLY")
#                 return redirect(url_for('manage_posts'))
#             else:
#                 updte = db.session.query(Tblposts).filter_by(pid=id).first()
#                 updte.pheading = pheading
#                 updte.pdescription = pdescription
#                 updte.pthumbnail = hello.pthumbnail
#                 updte.catid = pcategory
#                 updte.pdetails = pdetails
#                 db.session.commit()
#                 flash("POST AS BEEN UPDATED")
#                 return redirect(url_for('manage_posts'))
#         else:
#             cat = Category.query.all()
#             posts = db.session.query(Tblposts,Category).filter(Tblposts.pid==id).first()
#             return render_template("admin/edit-post.html", id=id,cat=cat, posts=posts)
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return redirect(url_for('login'))
#
# @app.route("/edit-post/action_delete=<int:id>", methods=['POST','GET'])
# def delete_post(id):
#     cats = Category.query.all()
#     if session.get('admin'):
#         post = db.session.query(Tblposts).filter(Tblposts.pid == id).first()
#         if post is None:
#             flash("This Item is Already Deleted")
#             return redirect(url_for('manage_posts'))
#         else:
#             record= db.session.query(Tblposts).filter(Tblposts.pid == id).first()
#             os.remove(app.config['UPLOAD_FOLDER']+record.pthumbnail)
#             db.session.delete(record)
#             db.session.commit()
#             flash('Post Has been Deleted')
#             return redirect(url_for('manage_posts'))
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
# @app.route("/add-category", methods=['POST','GET'])
# def add_category():
#     current = Category.query.all()
#     if session.get('admin'):
#         if request.method == 'POST':
#             cats = request.form.get('cname').replace(" ","").lower()
#             record = Category.query.filter(Category.cname==cats).first()
#             if record:
#                 error = "Category Already Exist"
#                 return render_template("admin/add-category.html", error=error)
#             else:
#                 cat = Category(cname=cats)
#                 db.session.add(cat)
#                 db.session.commit()
#                 flash('Category Added Successfully')
#         return render_template("admin/add-category.html")
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
# @app.route("/manage-category")
# def manage_category():
#     if session.get('admin'):
#         cats= db.session.query(Category).all()
#         return render_template("admin/manage-category.html",cats=cats)
#     else:
#         return render_template("admin/login.html")
#
# @app.route("/edit-category/action_id=<id>", methods=['POST','GET'])
# def edit_category(id):
#     if session.get('admin'):
#         if request.method == 'POST':
#             new=request.form.get("cname").lower().replace(" ","")
#             exist= Category.query.filter_by(cname=new).first()
#             if exist:
#                 error='CATEGORY ALREADY EXIST!'
#                 cat = db.session.query(Category).filter_by(cid=id).first()
#                 return render_template("admin/edit-category.html", id=id, cat=cat, error=error)
#             else:
#                 b = db.session.query(Category).filter_by(cid=id).first()
#                 b.cname = new
#                 db.session.commit()
#                 flash("UPDATED SUCCESSFULLY")
#                 return redirect(url_for('manage_category'))
#         else:
#             cat= db.session.query(Category).filter_by(cid=id).first()
#             return render_template("admin/edit-category.html",id=id, cat=cat)
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#     return redirect(url_for('login'))
#
# @app.route("/edit-contact", methods=['POST','GET'])
# def edit_contact():
#     if session.get('admin'):
#         contact= db.session.query(Tblcontact).order_by(Tblcontact.id.desc()).filter_by(id=Tblcontact.id).first()
#         if request.method == 'POST':
#             phone=request.form.get("contact")
#             email = request.form.get("email")
#             fax=request.form.get("fax")
#             address=request.form.get("address")
#             contact = db.session.query(Tblcontact).order_by(Tblcontact.id.desc()).filter_by(id=Tblcontact.id).first()
#             contact.phone=phone
#             contact.email=email
#             contact.address=address
#             contact.fax=fax
#             db.session.commit()
#             return render_template('admin/edit-contact.html', contact=contact)
#         else:
#             return render_template('admin/edit-contact.html', contact=contact)
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return redirect(url_for('login'))
#
# @app.route("/edit-about", methods=['POST','GET'])
# def edit_about():
#     if session.get('admin'):
#         abt= db.session.query(TblAbout).first()
#         if request.method == 'POST':
#             new=request.form.get("summernote")
#             abt = db.session.query(TblAbout).first()
#             abt.about=new
#             db.session.commit()
#             return render_template('admin/edit-about.html', abt=abt)
#         else:
#             return render_template('admin/edit-about.html', abt=abt)
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return redirect(url_for('login'))
#
# @app.route("/manage-category/action_delete=<int:id>", methods=['POST','GET'])
# def delete_category(id):
#     cats = Category.query.all()
#     if session.get('admin'):
#         category = db.session.query(Category).filter(Category.cid
#                                                      == id).first()
#         if category is None:
#             error ="NO RECORD FOUND"
#             return render_template("admin/manage-category.html", cats=cats, error=error )
#         else:
#             record=  db.session.query(Category).filter(Category.cid==id).first()
#             db.session.delete(record)
#             db.session.commit()
#             flash('Category Has been Deleted Successfully')
#             return redirect(url_for('manage_category'))
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
#
# @app.route("/login" , methods=['POST','GET'])
# def login():
#     if request.method == "POST":
#         username = request.form.get("username")
#         password = request.form.get("password")
#         role= request.form.get('role').replace(" ","")
#         if role=='admin':
#             adm = Admin.query.filter_by(username=username).first()
#             if pbkdf2_sha256.verify(password, adm.password):
#                 session['admin'] = adm.username
#                 session['id']= adm.id
#                 return redirect(url_for('admin'))
#             else:
#                 error='Invalid Username or Password'
#                 return render_template("admin/login.html", error=error)
#         else:
#             mod= User.query.filter_by(username=username).first()
#             if pbkdf2_sha256.verify(password, mod.password):
#                 session['mod'] = mod.username
#                 session['id'] = mod.id
#                 return redirect(url_for('admin'))
#             else:
#                 error='Invalid Username or Password'
#                 return render_template("admin/login.html", error=error)
#     else:
#         return render_template("admin/login.html")
#
#
# @app.route("/about-us")
# def about():
#     # Contact US
#     contact = Tblcontact.query.order_by(Tblcontact.id.desc()).limit(1).all()
#     # latest 5 posts order by time
#     # Nop stands for number of posts
#     posts = Tblposts.query.order_by(Tblposts.ptime.desc()).all()
#     # random posts
#     random = Tblposts.query.order_by(func.random()).all()
#     count = Category.query.count()
#     # Fetch all category
#     posts_cat = Category.query.all()
#     about= TblAbout.query.order_by(TblAbout.id.desc()).limit(1).all()
#     # c = db.session.query(Business, Category)\
#     # .filter(Business.id == Category.cid
#     # ).all()
#     return render_template('/about.html', posts=posts, about=about, random=random, contact=contact, count=count,
#                            posts_cat=posts_cat)
#
# @app.route("/about-us=<id>", methods=['POST','GET'])
# def about_edit(id):
#     if session.get('admin'):
#         if request.method=="POST":
#             about= request.form.get('about')
#             abt = TblAbout.query.filter(TblAbout.id == id).first()
#             abt.about= about
#             db.session.commit()
#             flash('ABOUT UPDATED')
#         else:
#             abt = TblAbout.query.filter(TblAbout.id == id).first()
#             if abt is None:
#                 return redirect(url_for('admin'))
#             return render_template("admin/edit-about.html", abt=abt)
#     else:
#         flash('LOGIN FIRST TO PROCEED')
#         return render_template("admin/login.html")
#
#
# @app.route("/contact-us")
# def contact():
#     # Contact US
#     contact = Tblcontact.query.order_by(Tblcontact.id.desc()).limit(1).all()
#     # latest 5 posts order by time
#     # Nop stands for number of posts
#     posts = Tblposts.query.order_by(Tblposts.ptime.desc()).all()
#     # random posts
#     random = Tblposts.query.order_by(func.random()).all()
#     count = Category.query.count()
#     # Fetch all category
#     posts_cat = Category.query.all()
#
#     return render_template('/contact.html', posts=posts, random=random, contact=contact, count=count, posts_cat=posts_cat)
#
#
@app.route("/logout")
def logout():
    if session.get('admin'):
        session.clear()
        flash('YOUR SESSION HAS BEEN LOGGED OUT')
        return redirect(url_for('login'))
    elif session.get('user'):
        session.clear()
        flash('YOUR SESSION HAS BEEN LOGGED OUT')
        return redirect(url_for('user'))
    else:
        return redirect(url_for('home'))

# create  custom Error pages
#Invalid URL
@app.errorhandler(404)
def page_not_found(e):
    return render_template("404.html"),404

# Internal server error
@app.errorhandler(500)
def page_not_found(e):
    return render_template("500.html"),500


if __name__ == "__main__":

    app.run(debug=True)
