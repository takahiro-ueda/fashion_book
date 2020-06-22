$(function(){
  function appendOption(category){ // optionの作成
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendSizeOption(size){ // サイズセレクトボックスのオプションを作成
    var html = `<option value="${size.id}">${size.size}</option>`;
    return html;
  }

  function appendChidrenBox(insertHTML){ // 子セレクトボックスのhtml作成
    var childSelectHtml = '';
      childSelectHtml = `<div class='product-select-wrapper' id= 'children_wrapper'>
                          <div class='product_category-select'>
                            <select class="category_select-box" id="child_category" name="item[category_id]">
                              <option value="---">---</option>
                              ${insertHTML}
                            </select>
                          </div>
                          <div class= 'product_select-grandchildren'>
                          </div>
                        </div>`
    $('#children_box').append(childSelectHtml);
  }
  function appendgrandChidrenBox(insertHTML){ // 孫セレクトボックスのhtml作成
    var grandchildrenSelectHtml = '';
    grandchildrenSelectHtml = `<div class='product-select-wrapper' id= 'grandchildren_wrapper'>
                              <div class='product_category-select'>
                              <select class="category_select-box" id="grandchild_category" name="item[category_id]">
                              <option value="---">---</option>
                              ${insertHTML} 
                              </select>
                              </div>
                              <div class= 'product_select-grandchildren'>
                              </div>
                              </div>`;
    $('#grandchildren_box').append(grandchildrenSelectHtml);
  }
  function appendSizeBox(insertHTML){ // サイズ・ブランド入力欄の表示作成
    var sizeSelectHtml = '';
    sizeSelectHtml = `<div class='product-select-wrapper' id= 'size_wrapper'>
                        <div class='product_category-select'>
                          <select class="category_select-box" id="size_category" name="item[category_id]">
                            <option value="---">---</option>
                            ${insertHTML} 
                          </select>
                        </div>
                        <div class= 'product_select-grandchildren'>
                        </div>
                      </div>`;          
    $('#size_box').append(sizeSelectHtml);
  }

  $(document).on('change', '#category_select', function(){  // 親セレクトボックスの選択肢を変えたらイベント発火
    var productcategory = document.getElementById('category_select').value; 
  // ↑ productcategoryに選択した親のvalueを代入
    if (productcategory != '---'){
 // ↑ productcategoryが空ではない場合のみAjax通信を行う｡選択肢を初期選択肢'---'に変えると､通信失敗となってしまうため｡
      $.ajax({
        url: 'category_children',
        type: 'GET',
        data: { parent_name: productcategory },
        dataType: 'json'
      })
      .done(function(children){  // 送られてきたデータをchildrenに代入
        $("#children_box").empty();
        $("#grandchildren_box").empty();
        $('.size_box').val('');
        $('#size_box').css('display', 'none');
        var insertHTML = '';
        children.forEach(function(child){  
  // forEachでchildに一つずつデータを代入｡子のoptionが一つずつ作成される｡
          insertHTML += appendOption(child); 
        });
        appendChidrenBox(insertHTML); 
  //       $(document).on('change', '#category_select', function(){
  // // 通信成功時に親の選択肢を変えたらイベント発火｡子と孫を削除｡selectのidにかけるのではなく､親要素にかけないと残ってしまう
  //         $('#children_wrapper').remove(); 
  //         $('#grandchildren_wrapper').remove();
  //       })
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    } else {
      $("#children_box").empty();
      $("#grandchildren_box").empty();
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
  $(document).on('change', '#child_category', function(){ // document､もしくは親を指定しないと発火しない
    var productcategory = document.getElementById('child_category').value;
    if (productcategory != '---'){
    $.ajax ({
      url: 'category_grandchildren',
      type: 'GET',
      data: { child_id: productcategory },
      dataType: 'json'
    })
    .done(function(grandchildren){
      $("#grandchildren_box").empty();
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
      var insertHTML = '';
      grandchildren.forEach(function(grandchild){
        insertHTML += appendOption(grandchild);
        });
        appendgrandChidrenBox(insertHTML); 
         
        // $(document).on('change', '#child_category',function(){
        //   $('#grandchildren_wrapper').remove();
        //   })
        }) 
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $("#grandchildren_box").empty();
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
  $(document).on('change', '#grandchild_category', function(){ // 孫カテゴリー選択後のイベント
    // var productcategory = $('#grandchild_category option:selected').data('category');
    var productcategory = document.getElementById('grandchild_category').value;
    if (productcategory != "---"){ //孫カテゴリーが初期値でないことを確認
      console.log(this)
      $.ajax({
        url: 'category_size',
        type: 'GET',
        data: { grandchild_id: productcategory },
        dataType: 'json',
        success: function(data){ 
          console.log(data); 
         } 
      })
      .done(function(sizes){
        $('#size_wrapper').remove(); //孫が変更された時、サイズ欄以下を削除する
        // $('#brand_wrapper').remove();
        $('.size_box').val('');
        $('#size_box').css('display', 'block');
        if (sizes.length != 0) {
        var insertHTML = '';
        sizes.forEach(function(size){
          insertHTML += appendSizeOption(size);
          });
          appendSizeBox(insertHTML); 
          // $(document).on('change', '#grandchild_category',function(){
          //   $('#size_wrapper').remove(); //孫が変更された時、サイズ欄以下を削除する
          //   // $('#brand_wrapper').remove();
          // })
        }
      }) 
      .fail(function(){
        alert('サイズ取得に失敗しました');
      })
    } else {
      console.log('サイズ取得失敗')
      // $('#size_wrapper').remove(); //孫カテゴリーが初期値になった時、サイズ欄以下を削除する
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
  //孫カテゴリー選択によるイベント発火
  $(document).on('change', '#grandchildren_box', function() {
    var productcategory = $('#grandchildren_category option:selected').data('category');
    if (productcategory != "") {
      $('.size_box').val('');
      $('#size_box').css('display', 'block');
    } else {
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
});