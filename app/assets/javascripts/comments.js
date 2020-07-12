$(document).on('turbolinks:load', ()=> {
  function buildHTML(comment){
    var html = `<div class="comment__area__container">
                  <li class="comment__area__container__current">
                    <div class="comment__area__container__current__box">
                      <div class="comment__area__container__current__box__text">
                        <div class="comment__area__container__current__box__text__name">
                          <a href=/users/${comment.user_id}>${comment.user_name}</a>
                        </div>
                        <span class="comment__area__container__current__box__text__date pull-right">
                          ${ comment.created_at }
                        </span>
                        <link_to coordinate_comment_path(comment.coordinate_id, comment.id), method: :delete, remote: true, data: { confirm: '本当に削除しますか?' }, class: "comment__area__container__current__box__text__destroy">
                          <link_to coordinate_comment_path(comment.coordinate_id, comment.id), method: :delete, remote: true, class: "comment__area__container__current__box__text__destroy" data-index=${comment.id}>
                            <i class="fa fa-trash" style="color: black;"></i>
                          </div>
                        </div>
                      </div>
                      <div class="comment__area__container__current__box__entry">
                        ${ comment.text }
                      </div>
                    </div>
                  </li>
                </div>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
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
      $('#comments_area').append(html);
      $('form')[0].reset();
      $('#comments_area').animate({ scrollTop: $('#comments_area')[0].scrollHeight});
    })
    .fail(function(){
      alert("コメント送信に失敗しました");
    })
    .always(function(data){
      $('.comment__create__text__new__submit').prop('disabled', false);
    })
  })
})