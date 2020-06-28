$(document).on('turbolinks:load', ()=> {
  //DataTransferオブジェクトで、データを格納する箱を作る
  var dataBox = new DataTransfer();
  //querySelectorでfile_fieldを取得
  var file_field = document.querySelector('input[type=file]')
  //fileが選択された時に発火するイベント
  $('#image-form').change(function(){
    //選択したfileのオブジェクトをpropで取得
    var files = $('input[type="file"]').prop('files')[0];
    $.each(this.files, function(i, file){
      //FileReaderのreadAsDataURLで指定したFileオブジェクトを読み込む
      var fileReader = new FileReader();

      //DataTransferオブジェクトに対して、fileを追加
      dataBox.items.add(file)
      //DataTransferオブジェクトに入ったfile一覧をfile_fieldの中に代入
      file_field.files = dataBox.files

      var num = $('.contents__coordinate__new__image__icon').length + 1 + i
      fileReader.readAsDataURL(file);
　　　 //画像が10枚になったら超えたらドロップボックスを削除する
      // if (num == 10){
      //   $('#image-box__container').css('display', 'none')   
      // }
      //読み込みが完了すると、srcにfileのURLを格納
      fileReader.onloadend = function() {
        var src = fileReader.result
        var html= `<div class='contents__coordinate__new__image__icon' data-image="${file.name}">
                    <div class='contents__coordinate__new__image__icon--preview'>
                      <img src=${src} width="400" height="450" >
                    </div>
                    <div class='contents__coordinate__new__image__icon--delete'>削除</div>
                  </div>`
        //image_box__container要素の前にhtmlを差し込む
        $('#file').before(html);
      };
      //image-box__containerのクラスを変更し、CSSでドロップボックスの大きさを変えてやる。
      $('#file').attr('class', `contents__coordinate__new__image`)
    });
  });
  //削除ボタンをクリックすると発火するイベント
  $(document).on("click", '.contents__coordinate__new__image__icon__select--delete', function(){
    //プレビュー要素を取得
    var target_image = $(this).parent().parent()
    //プレビューを削除
    target_image.remove();
    //inputタグに入ったファイルを削除
    // file_field.val("")
  })
});