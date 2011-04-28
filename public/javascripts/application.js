$(document).ready(function(){
  submit_link_handler.call(this);
  qtip_handler.call(this);
  show_action_handler.call(this);
  add_people_attribute_handler.call(this);
});

function submit_link_handler(){
  $("a.submit").live("click",function(){
    $(this).parent().submit();
    return false;
  })
}

function show_action_handler(){
  $("table.index_table tbody tr").live("click",function(){
    var controller = $(this).attr("controller");
    var id = $(this).attr("o_id");
    window.location = "/"+controller+"/"+id+"/edit";
  });
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

function add_people_attribute_handler(){
  $(".add_new_people_attribute").live("click",function(){
    alert("yo");
  })
}