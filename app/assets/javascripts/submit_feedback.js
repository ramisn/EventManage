$(function() {
  var feedback = $( "#feedback_feedback" ),
  email = $( "#feedback_email" ),
  allFields = $( [] ).add( feedback ).add( email ),
  tips = $( ".validateTips" );

  function updateTips( t ) {
    tips.text( t ).addClass( "ui-state-highlight" );
    setTimeout(function() {
      tips.removeClass( "ui-state-highlight");
    }, 1000 );
  }

  function checkLength( o, n, min, max ) {
    if ( o.val().length > max || o.val().length < min ) {
      o.addClass( "ui-state-error" );
      updateTips( "Length of " + n + " must be between " + min + " and " + max + "." );
      return false;
    }
    else {
      return true;
    }
  }

  function checkRegexp( o, regexp, n ) {
    if ( !( regexp.test( o.val() ) ) ) {
      o.addClass( "ui-state-error" );
      updateTips( n );
      return false;
    }
    else {
      return true;
    }
  }

  $( "#dialog-form" ).dialog({
    autoOpen: false,
    height: 400,
    width: 550,
    position: [350,100],
    resizable: false,
    draggable: false,
    modal: true,
    buttons: [ { 
      text: "Submit",
      click: function() {
        var bValid = true;
        allFields.removeClass( "ui-state-error" );
        bValid = bValid && checkLength( email, "email", 6, 80 );

        bValid = bValid && checkRegexp( email, /^(\w+\.)*\w+@(\w+\.)+\w+$/, "invalid email. e.g yourname@gmail.com" );
        bValid = bValid && checkLength( feedback, "feedback", 1, 1000 );

        if ( bValid ) {
          $.ajax({
            type: "POST",
            url: "/feedback",
            data: $('form').serializeArray()
            });
          $( this ).dialog( "close" );
          $('#alert_success').show();
          setTimeout(function() {
            $('#alert_success').hide();
          }, 3000 );
        }
      }
    } ],
    close: function() {
      allFields.val( "" ).removeClass( "ui-state-error" );
    }
  });

  $( "#create-feedback" ).click(function() {
    $( "#dialog-form" ).dialog( "open" );
    });
});