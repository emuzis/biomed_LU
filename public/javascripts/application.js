$(document).ready(function(){
  submit_link_handler.call(this);
  qtip_handler.call(this);
  show_action_handler.call(this);
  add_people_attribute_handler.call(this);
  data_type_handler.call(this);
  remove_children_handler.call(this);
  add_new_group_handler.call(this);
  
  $("#sortable").sortable({
    update : function () {
      $(".countable").each(function(index){
        $(this).find(".order").val(index);
      });
    }
  });
  $("#sortable").disableSelection();
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
  $(".add_new_attribute").live("click",function(){
    var controller = $(this).attr("controller");
    $.ajax({
      url: "/"+controller+"/new_attribute",
      data: {},
      type: "GET",
      success: function(data) {
        $(".attribute_groups").append(data);
      }
    });
    return false;
  });
}

function data_type_handler(){
  $(".lov_list").live("change",function(){
    if ($(this).val() != "") {
      $(this).parent().find("input[name$='[data_type]']").attr("checked", false);
    }
    return false;
  });
  $("input[name$='[data_type]']").live("click",function(){
    $(this).parent().find("select.lov_list").val("");
  });
}

function remove_children_handler(){
  $("a.remove_record").live("click",function(){
    var parent = $(this).parent();
    parent.find(".destroy_flag").val(1);
    parent.hide();
    return false;
  })
}

function add_new_group_handler(){
  $(".add_new_group").live("click",function(){
    var id = $("#data_groups").val();
    if (id != "") {
      var controller = $(this).attr("controller");
      $.ajax({
        url: "/"+controller+"/new_group",
        data: {id:id},
        type: "GET",
        success: function(data) {
          $(".attribute_groups").append(data);
          $("#data_groups").val("");
          qtip_handler();
        }
      });
    }
    return false;
  });
}