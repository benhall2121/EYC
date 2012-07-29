// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});
	
$(document).ready(function() {
	
  $('.q_type_select').live('change', function(){
  	var q_type_value = $(this).val() // 1 = Multiple Choice(Only One Answer), 2 = Multiple Choice(Multiple Answers), 3 = Rating 1-10, 4 = Text Box
  	
  	   // Have the answers appear and not be deleted. Also show the add answer button
  	   $(this).parent().siblings('.answer_fields').show();
  	   $(this).parent().siblings('.answer_fields').find("input[type=hidden]").val("0");
  	   $(this).parent().siblings('.add_answer_div').show();
  	   
  	//if the type is a rating or text box, we don't need answers. So hide the answers and have any answers that were created be deleted on save, Also hide the add answer button   
  	if (q_type_value == 3 || q_type_value == 4){
  	   $(this).parent().siblings('.answer_fields').find("input[type=hidden]").val("1");
  	   $(this).parent().siblings('.answer_fields').hide();
  	   $(this).parent().siblings('.add_answer_div').hide();
  	} 
  });
  
  $('.show_answers_wrapper').each(function(){
    these_answers = $(this).find('.answers_hidden_fields');
    
    if(these_answers.length > 0){ 
      //Passing the whole div so that we can access where to place the chart  
      drawPieChart($(this));  
    }
  });

});


function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function share(share_to, link_to_share){
  var domain = 'http://' + document.domain;
  if(domain == "http://localhost"){ domain = "http://localhost:3000"; }
  
  var title = 'I mustache you for a favor. Will you take this survey for me!'
  
  if(share_to == undefined || share_to == ""){
     share_to = "facebook";
  }
  
  if (share_to == "twitter"){
    var url = "http://twitter.com/share?text=" + title + " " + domain + link_to_share;
  } else {
    var url = "http://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(domain) + link_to_share + '&t=' + title;
  }
  
  var windowWidth = 600;
  var windowHeight = 350;
  var windowLeft = (screen.width/2)-(windowWidth/2)
  var windowTop = (screen.height/2)-((windowHeight/2)+50)
     
  myWindow=window.open(encodeURI(url),'','width=' + windowWidth + ',height=' + windowHeight + ', left=' + windowLeft + ', top='+ windowTop);
  myWindow.focus();
  
  
  return false;
}


function drawPieChart(whole_div) {
      var all_answers = whole_div.find('.answers_hidden_fields'); 
      
      var data = new google.visualization.DataTable();
      data.addColumn('string', 'Answers');
      data.addColumn('number', 'AnswerCount');
      
      all_answers.each(function(j, k){
        data.addRow([$(k).attr('name'), parseFloat($(k).val())]);       
      });
      
      // Set chart options
      var options = {'is3D':true};

      chart_id = "chart_div_" + whole_div.attr('id').replace('chart_', '');
      
      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.PieChart(document.getElementById(chart_id));
      chart.draw(data, options);
}