jQuery.noConflict($);
/* Ajax functions */
jQuery(document).ready(function($) {
    //onclick
    $("#loadMore").on('click', function(e) {
        //init
        var number = $(this).data('number');
        var that = $(this);
        var page = $(this).data('page');
        var newPage = page + 1;
        var ajaxurl = that.data('url');
        //ajax call
        
        $.ajax({
            url: ajaxurl,
                  cache: false,
            type: 'post',
            data: {
                number: number,
                page: page,
                action: 'ajax_script_load_more'
            },
            error: function(response) {
                console.log(response);
            },
            success: function(response) {
                //check
                if (response == 0) {
                    $('#ajax-content').append('<div class="text-center"><h3>You reached the end of the Posts!</h3><p>No more posts to load.</p></div>');
                    $('#loadMore').hide();
                    
                } else {
                    that.data('page', newPage);
                    $('#ajax-content').append(response);
                }
            }
        });
    });
});

jQuery.noConflict($);
/* Ajax functions */
jQuery(document).ready(function($) {
    //onclick
    $("#loadMoredeal").on('click', function(e) {
        //init
        var number = $(this).data('number');
        var that = $(this);
        var page = $(this).data('page');
        var newPage = page + 1;
        var ajaxurl = that.data('url');
        //ajax call
        
        $.ajax({
            url: ajaxurl,
                  cache: false,
            type: 'post',
            data: {
                number: number,
                page: page,
                action: 'ajax_script_load_more_deal'
            },
            error: function(response) {
                console.log(response);
            },
            success: function(response) {
                //check
                if (response == 0) {
                    $('#ajax-content-deal').append('<div class="text-center"><h3>You reached the end of the Posts!</h3><p>No more posts to load.</p></div>');
                    $('#loadMoredeal').hide();
                    
                } else {
                    that.data('page', newPage);
                    $('#ajax-content-deal').append(response);
                }
            }
        });
    });
});

jQuery.noConflict($);
/* Ajax functions */
jQuery(document).ready(function($) {
    //onclick
    $("#myRangeprice").on('click', function(e) {
        //init
        var number = $(this).data('number');
        var that = $(this);
        var page = $(this).data('page');
        var newPage = page;
        var ajaxurl = that.data('url');
        //ajax call
        
        $.ajax({
            url: ajaxurl,
                  cache: false,
            type: 'post',
            data: {
                number: number,
                page: page,
                action: 'ajax_script_load_more_price'
            },
            error: function(response) {
                console.log(response);
            },
            success: function(response) {
                //check
                if (response == 0) {
                    $('#ajax-content-deal').append('<div class="text-center"><h3>You reached the end of the Posts!</h3><p>No more posts to load.</p></div>');
                    $('#myRangeprice');
                    
                } else {
                    that.data('page', newPage);
                    $('#ajax-content-deal').append(response);
                }
            }
        });
    });
});
