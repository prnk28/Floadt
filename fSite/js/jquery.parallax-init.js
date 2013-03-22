/*

*/

var $w, 

	winHeight, 

	winWidth,

	pos,

	scroll = {

		paneOffset : 0,

		stories : [],

		learn : {

			call : false,

			current : '',

			init : function(el){

				if (this.current != el) {

					this.reset();

				}

				this.current = el;

				if (!this.call) {

					this.call = true;

					if (this.current.length < 2) return;

					$(this.current+' .learn_more').stop(true,true).fadeIn(1500, function(){

						$(this).css('display','block')

							.effect('bounce', { times : 3 }, 300);

					});

				}

			},

			reset : function(){

				$('.learn_more').hide();

				this.call = false;

			}

		},

		getStarted : {

			call : false,

			init : function(){

				el = $('#GetStarted');

				l = (!this.call ? 0 : 100);

				this.call = (l == 0 ? true : false);

				el.animate({left:l+'%'}, 250, 'linear', function(){

					$('#GetStarted .col div').hide();				

				});

			}

		},

		contact : {

			call : false,

			init : function(){

				el = $('#Contact');

				this.call = (!this.call ? true : false);

				el.fadeToggle(1000, 'easeInOutExpo');

			}

		},

		slideshow : {

			call : false,

			current : '',

			init : function(el){

				if (this.current != el) {

					this.reset(this.current);

				}

				this.current = el;

			

				if (!this.call) {

					this.call = true;

					$('.slide_indicator', $(el)).fadeIn();

					$(this.current+' .learn_more').fadeIn();

				

					this.customStart(el.substr(1), 0);

				

					// register arrow key listeners

					$(document).bind('keyup', function(e){

						switch(e.keyCode){

							case 37:

								$(el+' .slide_container').trigger( 'prev' );

							break;

							case 39:

								$(el+' .slide_container').trigger( 'next' );

							break;

						}

					});

				}

				scroll.learn.reset();

			},

			customStart : function(id, pos){

				var $parent = $('#'+id).find('.slide').eq(pos);



				switch(id){

					case "Features" :

						$('.text', $parent).hide();

						$('.text', $parent).each(function(ind){

							i = (ind+1)*0.9;

							$(this).stop(true,true).delay(650*i).fadeIn(1000);

						});

					break;

					case "About" :

						var users = new Array();

						$('#Users .box').hide().each(function(){

							users.push(this);

						});

						users.sort(function() {return 0.5 - Math.random()});

						$.each(users, function(ind, user){

							i = ind+1;

							$(user).stop(true,true).delay(250*i).fadeIn(500);

						});

					break;

				}

			},

			onBefore : function( $parent, item, elem ){	

				var top_id = $parent.attr('id');

			

				switch(top_id){

					case "Features" :

						$('.sprite', $parent).css('left','');

						$('.text', $parent).fadeOut();

						$('.sprite', elem).each(function(ind){

							leftCss = parseFloat($(this).css('left'));

							$(this).css({

								left: leftCss + 200

							});

						});



						// begin sliding

						$('.sprite', elem).each(function(ind){

							i = (ind+1);

							x = 1 + i*Math.PI/15;

							leftCss = parseFloat($(this).css('left'));

							$(this).delay(500).stop(true,true).animate({

								left: leftCss - 200

							}, 800*x);

						});

					

					break;

					case "About" :

						$('#Users .box').hide();

						$('#Customers img').fadeOut(1000);

						$('#Testimony img.sprite').fadeOut(1000);

					break;

				}

			},

			onAfter : function ( $parent, elem ){

				// called on init and after slide loads	

				var top_id = $parent.attr('id'),

					pos = 0;

				

				$('.slide_indicator a', $parent).not('.prev, .next').each(function(ind){

					if ($(this).hasClass('active')) pos = ind;

				});

			

				switch(top_id){

					case "Features" :

						scroll.slideshow.customStart(top_id, pos);

					break;

					case "About" :

						switch(elem.id){

							case "Users" :

								scroll.slideshow.customStart(top_id, 0);

							break;

							case "Customers" :

								$('#Customers img').delay(500).fadeIn(2000);

							break;

							case "Testimony" :

								$('#Testimony img').eq(1).fadeIn(1000, function(){

									$('#Testimony img').eq(0).fadeIn(1000, function(){

										$('#Testimony img').eq(2).fadeIn(1000);

									});

								});

							break;

						}

				

					break;

				}

			},

			reset : function(el){

				$('.slide_indicator', $(el)).fadeOut();

				$(el+' .slide_container').trigger( 'goto', [ 0 ] );

				this.call = false;

				this.current = '';

				$(document).unbind('keyup');

			}

		},

		plans : {

			call : false,

			init : function(){

				if (!this.call) {

				

					if (!this.call) this.reset();

					this.call = true;

				

					$('#Plans h4').animate({

						textIndent: '0px'

					}, 1000);

					$('#Plans .box:eq(0)').animate({ left: '0px' }, 1000);

					$('#Plans .box:eq(1)').animate({ bottom: '0px' }, 1000);

					$('#Plans .box:eq(2)').animate({ right: '0px' }, 1000);

					$('#Plans .get_started').animate({ bottom: '0px' }, 1200);

					scroll.learn.init('#Plans');

				}

			},

			reset : function(){

				scroll.learn.reset();

				$('#Plans h4').css({ textIndent: '-4999px' });

				$('#Plans .box:eq(0)').css({ left: '-1000px' });

				$('#Plans .box:eq(1)').css({ bottom: '-2000px' });

				$('#Plans .box:eq(2)').css({ right: '-1000px' });

				$('#Plans .get_started').css({ bottom: '-1000px' });

				this.call = false;

			}

		},

		adjustPane : function(){

			// recalculate outer pane margins

			scroll.paneOffset = ($(window).width() - $('.slide').width())/2;



			$('.story').each(function(){

				var $parent = $(this);

				$('.slide', $parent).each(function(ind){

					if (ind == 0) 

						$(this).css( 'marginLeft', scroll.paneOffset );

					if (ind == $('.slide', $parent).length -1) 

						$(this).css( 'marginRight', scroll.paneOffset );

				});



				// recalculate total pane widths

				var totalFeatureWidth = 0;

				$('.slide', $parent).each(function(idx){

					totalFeatureWidth += $(this).outerWidth(true);

				}).parent().css({

					width : totalFeatureWidth + 'px'

				});

			});

		},

		activateMenu : function(ind){

			var nav = $('#Header a');

			nav.parent().removeClass('active');

			if (ind < 4) nav.eq(ind).parents('li').addClass('active');

		},

		viewing : function(){

			minus = winHeight/2;

			$('.story').removeClass('viewing')

			if (pos < scroll.stories[0].offset.bottom-60-minus) {

				$('.story').eq(0).addClass('viewing'); 

				$('.story').eq(1).addClass('viewing'); 

			}

			else if (pos < scroll.stories[1].offset.bottom-60-minus) {

				$('.story').eq(1).addClass('viewing'); 

				$('.story').eq(2).addClass('viewing'); 

			}

			else if (pos < scroll.stories[2].offset.bottom-60-minus) {

				$('.story').eq(2).addClass('viewing'); 

				$('.story').eq(3).addClass('viewing'); 

			}

			else if (pos < scroll.stories[3].offset.bottom-60-minus) {

				$('.story').eq(3).addClass('viewing'); 

				$('.story').eq(4).addClass('viewing'); 

			}

			else $('.story').eq(4).addClass('viewing'); 

			scroll.adjustPane();

		},

		moving : function(){ 

			scroll.viewing();



			// actions for when story is inview

			var viewing = $('.viewing'),

				idx = viewing.index('.story'),

				story = $('.story').eq(idx);

				

			scroll.activateMenu(idx);



			// every story frame here

			$('.story').each(function(i){

				var story = $(this),

					storyOffsetTop = scroll.stories[i].offset.top,

					storyOffsetBottom = scroll.stories[i].offset.bottom;



				if (story.hasClass('viewing')) {

					if (i == 0) {

						$('#Intro').css({'backgroundPosition': newPos(50, winHeight, pos, 750, 0.4)});

						$('#Intro .fixed').css({

							'top': (5 - pos/50) + '%'

						});

						scroll.learn.reset();

					}

					if (i == 1) {

						// slide in step

						var r1=storyOffsetTop-700, r2=storyOffsetBottom;

						if (pos > r1 && pos < r2){

							curr = 100 - (pos - r1)/7;

							curr = (curr < 0 ? 0 : curr)

							$('#Features .slide_container, #Features .controls').css({

								'top': curr+'%'

							});

							scroll.slideshow.init('#Features');

						} else {

							$('#Features .slide_container, #Features .controls').css({

								'top': 110 + '%'

							});

							scroll.slideshow.reset('#Features');

						}

						scroll.learn.reset();

					}

					if (i == 2) {

						$('#Plans').css({'backgroundPosition': newPos(50, winHeight, pos, 2200, 0.3)});

					

						// slide up plans

						var r1=storyOffsetTop-400,r2=storyOffsetBottom;

						if (pos > r1 && pos < r2){

							curr = 100 - (pos - r1)/4;

							curr = (curr < 10 ? 10 : curr)

							$('#Plans .fixed').css({

								'top': curr + '%'

							});

							scroll.plans.init();

						} else {

							$('#Plans .fixed').css({

								'top': 110 + '%'

							});

							scroll.plans.reset();

						}

					}

					if (i == 3) {					

						// slide up about intro

						var r1=storyOffsetTop-700, r2=storyOffsetBottom;

						if (pos > r1 && pos < r2){

							curr = 100 - (pos - r1)/7;

							curr = (curr < 0 ? 0 : curr)

							$('#About .slide_container, #About .controls').css({

								'top': curr + '%'

							});

							scroll.slideshow.init('#About');

						} else {

							$('#About .slide_container, #About .controls').css({

								'top': 110 + '%'

							});

							scroll.slideshow.reset('#About');

						}

						scroll.learn.reset();

					}

					if (i == 4) {

						// slide up finale

						var r1=storyOffsetTop-400, r2=storyOffsetBottom, curr = 100 - (pos - r1)/3.33;

						if (pos > r1 && pos < r2){

							curr = (curr < 0 ? 0 : curr);

							$('#Finale .fixed').css({

								'top': (pos > r1 && pos < r2 ? curr : 100) + '%'

							});

							$('#Finale .to_top').css('left',($(window).width()-1024)/2);

							$('#Finale').css('height',winHeight-60-72);

						} else {

							$('#Finale .fixed').css({

								'top': 100 + '%'

							});

						}

					}

				}

			});

		}

	}



function newPos(x, windowHeight, pos, adjuster, inertia){

	return x + '% ' + (-((windowHeight + pos) - adjuster) * inertia)  + 'px';

}

	

$(document).ready(function() { 

	$w = $(window), winHeight = $w.height(), winWidth = $w.width();

	

	// add scroll.stories[i].offset object to array

	$('.story').each(function(i){

		var story = $(this);

		scroll.stories[i] = {

			id : story.attr('id'),

			height : story.outerHeight(),

			offset : {

				top : story.offset().top,

				bottom : story.offset().top + story.outerHeight()

			}

		}

	});

		

	// scroll to href for nav

	$('#Nav a, .to_top').not('.get_started, .talk_to_us, .log_in').click(function(){

		var href = $(this).attr('href'),

			scrollPos = $(window).scrollTop(),

			targetPos = $(href).offset().top,

			difference = (scrollPos > targetPos ? scrollPos - targetPos : targetPos - scrollPos),

			speed = difference * 0.5;

		$.scrollTo(href,speed);

		return false;

	});

	

	// scroll to the href for learn more buttons

	$('#Intro .learn_alt, .learn_more').click(function(){

		$.scrollTo( $(this).attr('href'), 800);

		return false;

	});

	

	// calculate pane widths

	scroll.paneOffset = ( winWidth - $('.slide').width() )/2;

	$('.story').each(function(ind){

		var $parent = $(this);

		$('.slide', $parent).each(function(ind){

			if (ind == 0) 

				$(this).css( 'marginLeft', scroll.paneOffset );

			if (ind == $('.slide', $parent).length -1) 

				$(this).css( 'marginRight', scroll.paneOffset );

		});

	});

	

	// init slideshows

	$('#Features, #About').each(function(ind){

		var $parent = $(this), $i = ind;

		

		$('.prev, .next', $parent).click(function(){

			var pos = 0,

				total = 0,

				isNext = $(this).hasClass('next'),

				isPrev = $(this).hasClass('prev');

				

			$('.slide_indicator a', $parent).not('.prev, .next').each(function(ind){

				if ($(this).hasClass('active')) pos = ind;

				if (ind>0) total += 1;

			});

			href = false;

			p = $parent.parent();

			if (pos == 0 && isPrev) {

				href = '#' + p.prev().attr('id');

			}

			if (pos == total && isNext) {

				href = '#' + p.next().attr('id');

			}

			if (href) $.scrollTo( href, 800);

		});



		$($parent).serialScroll({

			target:'.slide_container',

			items:'.slide',

			prev:'a.prev',

			next:'a.next',

			axis:'x',

			navigation: $('.slide_indicator a', $parent).not('.prev, .next'),

			duration:500,

			force:true,

			cycle:false,

			offset: -1 * scroll.paneOffset,

			onBefore:function( e, elem, $pane, items, pos ){

				// set indicator

				this.navigation.each(function(i){

					$(this).removeClass('active');

					if (i == pos) $(this).addClass('active');

				});



				// called right after click 

				isNext = $(e.target).hasClass('next');

				idx = (isNext ? pos - 1 : pos + 1);

				var item;

				$.each(items, function(it, ind){

					if (ind == idx) item = it;

				})

				

				// reset previous slide

				$('.slide', $parent).css({opacity:0.3});

				$(elem).css({opacity:1});



				scroll.slideshow.onBefore($parent, item, elem);

				

				// update offset if page resized

				if (this.offset != -scroll.paneOffset) this.offset = -scroll.paneOffset;

				

			},

			onAfter:function( elem ){

				// controls z-index reassignment

				$('.controller').parent().css({zIndex:100});

				scroll.slideshow.onAfter($parent, elem);

			}		

		});

		

	});

	

	// controller z-index reassignment

	$('.controller').click(function(){

		$(this).parent().css({zIndex:0});

	});

	

	// get started slide

	$('.get_started, .back').click(function(){

		scroll.getStarted.init();

		return false;

	});

	

	// get started btn hovers

	$('#GetStarted .btn').hover(function(){

		$(this).next().stop(true,true).fadeIn();

	}, function(){

		$(this).next().stop(true,true).fadeOut();

	});

	

	// talk to us modal

	$('.talk_to_us, .close').click(function(){

		scroll.contact.init();

		return false;

	});

	

	$w.bind('resize', function(){

		winHeight = $(window).height(),

		winWidth = $(window).width();

		scroll.moving();

	});

	$w.bind('scroll', function(e){

		pos = $(this).scrollTop();

		scroll.moving();		

	});

	$(document).bind('keydown keypress keyup', function(e){

		switch(e.keyCode){

			case 33:

			case 34:

			case 35:

			case 36:

			case 38:

			case 40:

				e.preventDefault();

				return false;

			break;

		}

	});

	

	// start viewing/moving trackers

	scroll.viewing();

	scroll.moving();

	

	setTimeout(function(){

		scrollTo(0,$w.scrollTop()+1);

	}, 1000);

});