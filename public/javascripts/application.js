$(document).ready(function(){
  submit_link_handler.call(this);
  qtip_handler.call(this);
});

function submit_link_handler(){
  $("a.submit").live("click",function(){
    $(this).parent().submit();
    return false;
  })
}

function qtip_handler(){
  $(".has_qtip").each(function(){
    var qtext = $(this).attr("qtext");
    $(this).qtip({
      content: qtext,
      show: "focus",
      hide: "blur",
      position: {
        corner: {
          target: "rightMiddle",
          tooltip: "leftMiddle"
        }
      },
      style: { 
         width: 200,
         padding: 0,
         background: "#3884CF",
         color: "white",
         textAlign: "center",
         fontWeight: "bold",
         border: {
            width: 5,
            radius: 5,
            color: "#3884CF"
         },
         tip: "leftMiddle"
      }
    })
  });
}