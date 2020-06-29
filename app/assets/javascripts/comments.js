$(document).on('turbolinks:load', ()=> {
  function buildHTML(comment){
    var html = `<p>
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>
                    ：
                  </strong>
                  ${comment.text}
                </p>`
    return html;
  }
  // $('#new_comment').on('submit', function(e){
  $('#comments_area').on('submit', function(e){
    e.preventDefault();
    console.log(this)
    var formData = new FormData(this);
    var url = $(this).attr('action')
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comments').append(html);
      $('.contents__coordinate__show__left__comment__create__text__new__box').val('');
      $('.contents__coordinate__show__left__comment__create__text__new__submit').prop('disabled', false);
    })
    .fail(function(){
      alert('error');
    })
  })
})