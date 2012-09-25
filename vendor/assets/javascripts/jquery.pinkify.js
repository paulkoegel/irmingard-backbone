(function( $ ) {
  var elm = document.createElement('div'),
    animation = false,
    keyframeprefix = '',
    domPrefixes = 'webkit Moz O ms Khtml'.split(' '),
    pfx  = '';
  window.animationstring = 'animation';
  if( elm.style.animationName ) { animation = true; }

  if( animation === false ) {
    for( var i = 0; i < domPrefixes.length; i++ ) {
      if( elm.style[ domPrefixes[i] + 'AnimationName' ] !== undefined ) {
        pfx = domPrefixes[ i ];
        window.animationstring = pfx + 'Animation';
        keyframeprefix = '-' + pfx.toLowerCase() + '-';
        animation = true;
        break;
      }
    }
  }

  var methods = {
     init : function( options ) {
      var settings = $.extend( {
        'animation'   : {
          'direction' : 'left',
          'duration'  : 0.2
        },
        'imageUrl'    : 'pinkie_parasprite_polka_by_fluttershylover.gif',
        'imageWidth'  : 106,
        'imageHeight' : 126,
        'audioAttr'   : {
          // 'autoplay' : 'autoplay',
          // 'loop'     : 'true'
        },
        'aAttr'       : {
          'href'   : 'http://www.youtube.com/watch?v=6UXGEbaP5Ug&list=PL7BFEA256F3B8B0DF&index=5',
          'target' : '_blank'
        },
        'audioFiles'  : [
          // 'http://dl.dropbox.com/u/23165202/Pinkies%20Parasprite%20Polka%20%5BKeep-Mp3.com%5D.ogg',
          // 'http://dl.dropbox.com/u/23165202/Pinkies%20Parasprite%20Polka%20%5BKeep-Mp3.com%5D.mp3'
        ],
        'click' : function () {
          $(this).pinkify('destroy');
        }
      }, options);


      return this.each(function(){

        var $this = $(this),
            data = $this.data('pinkify');

        // If the plugin hasn't been initialized yet
        if ( ! data ) {

          var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghiklmnopqrstuvwxyz",
              string_length = 8,
              element_unique_id = '',
              pinkify = $('<a class="pinkify"/>').attr(settings.aAttr);
          for (var i=0; i<string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            element_unique_id += chars.substring(rnum,rnum+1);
          };

          if (!$.isEmptyObject( settings.audioFiles))
          {
            var audio = $('<audio>').attr(settings.audioAttr);
            $.each(settings.audioFiles, function (i, file) {
              $('<source>').attr('src', file).appendTo(audio)
            });
            audio.appendTo(pinkify);
          }

          // IN SECONDS!
          var delay = $this.outerWidth() / settings.imageWidth * settings.animation.duration;
              span = $('<span/>').css({
                'width': '100%',
                'height': settings.imageHeight+'px',
                'position': 'absolute',
                'bottom': '0px',
                'display': 'block',
                'background': 'url("'+settings.imageUrl+'") repeat-x',
              })[0];
          span.style[window.animationstring] = 'pinkify-entrance-'+element_unique_id+' '+delay+'s linear, pinkify-'+element_unique_id+' '+settings.animation.duration+'s linear infinite '+delay+'s';
          pinkify.append(span);

          var keyframes1 = '@' + keyframeprefix + 'keyframes pinkify-'+element_unique_id+' { '+
                            'from{background-position: '+(settings.animation.direction === 'right' ? '-' : '')+settings.imageWidth+'px; } '+
                            'to{background-position: 0; }'+
                          '}',
              keyframes2 = '@' + keyframeprefix + 'keyframes pinkify-entrance-'+element_unique_id+' { '+
                            'from{'+(settings.animation.direction === 'right' ? 'right' : 'left')+': 100%; width:0} to{'+(settings.animation.direction === 'right' ? 'right' : 'left')+': 0%;}'+
                          '}';

          var s;
          // if( document.styleSheets && document.styleSheets.length ) {

          //     document.styleSheets[0].insertRule( keyframes1, 0 );
          //     document.styleSheets[0].insertRule( keyframes2, 0 );

          // } else {

            var s = document.createElement( 'style' );
            s.innerHTML = keyframes1 + keyframes2;
            document.getElementsByTagName( 'head' )[ 0 ].appendChild( s );

          // }

          $this.append(pinkify).data('pinkify', {
              target : $this,
              pinkify : pinkify,
              style: s
          }).bind('click.pinkify',settings.click);

        }
      });
     },
     destroy : function( ) {

       return this.each(function(){

         var $this = $(this),
             data = $this.data('pinkify');

         $this.unbind('click.pinkify');
         data.pinkify.remove();
         $this.removeData('pinkify');

       })

     },
  };

  if ( animation === false ) {
    $.fn.pinkify = function( options ) {
      $.error( 'Pinkify plugin is not yet available for browsers that do not support native CSS animations');

      // Don't do anything, 'cause this is a first version anyway
      return this;
    };
  } else {
    $.fn.pinkify = function( method ) {

      if ( methods[method] ) {
        return methods[method].apply( this, Array.prototype.slice.call( arguments, 1 ));
      } else if ( typeof method === 'object' || ! method ) {
        return methods.init.apply( this, arguments );
      } else {
        $.error( 'Method ' +  method + ' does not exist on jQuery.pinkify' );
      }
    }

  };
})( jQuery );
