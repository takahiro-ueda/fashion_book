$(document).on('turbolinks:load', function(){
  function appendOption(category){ // optionの作成
    var html = `<option value="${category.id}">${category.name}</option>`;
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
    $('.product_select-children').append(childSelectHtml);
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
    $('.product_select-grandchildren').append(grandchildrenSelectHtml);
  }



  $(document).on('change', '#category_select', function(){  // 親セレクトボックスの選択肢を変えたらイベント発火
    var productcategory = document.getElementById('category_select').value; 
  // ↑ productcategoryに選択した親のvalueを代入
    if (productcategory != '---'){
 // ↑ productcategoryが空ではない場合のみAjax通信を行う｡選択肢を初期選択肢'---'に変えると､通信失敗となってしまうため｡
      $.ajax({
        url: 'category_children',
        type: 'GET',
        data: { productcategory: productcategory },
        dataType: 'json'
      })
      .done(function(children){  // 送られてきたデータをchildrenに代入
        $("#child_category").empty();
        $("#grandchildren_category").empty();
        $('.size_box').val('');
        $('#size_box').css('display', 'none');
        var insertHTML = '';
        children.forEach(function(child){  
  // forEachでchildに一つずつデータを代入｡子のoptionが一つずつ作成される｡
          insertHTML += appendOption(child); 
        });
        appendChidrenBox(insertHTML); 
        $(document).on('change', '#category_select', function(){
  // 通信成功時に親の選択肢を変えたらイベント発火｡子と孫を削除｡selectのidにかけるのではなく､親要素にかけないと残ってしまう
          $('#children_wrapper').remove(); 
          $('#grandchildren_wrapper').remove();
        })
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    } else {
      $("#child_category").empty();
      $("#grandchildren_category").empty();
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });


  // document､もしくは親を指定しないと発火しない
  $(document).on('change', '#child_category', function(){
    var productcategory = document.getElementById('child_category').value;
    if (productcategory != '---'){
    $.ajax ({
      url: 'category_grandchildren',
      type: 'GET',
      data: { productcategory: productcategory },
      dataType: 'json'
    })
    .done(function(grandchildren){
      $("#grandchildren_category").empty();
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
      var insertHTML = '';
      grandchildren.forEach(function(grandchild){
        insertHTML += appendOption(grandchild);
        });
        appendgrandChidrenBox(insertHTML); 
         
        $(document).on('change', '#child_category',function(){
          $('#grandchildren_wrapper').remove();
          })
        }) 
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
    } else {
      $("#grandchildren_category").empty();
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
    //孫カテゴリー選択によるイベント発火
  $(document).on('change', '#grandchildren_category', function() {
    // var grandchildId = $('#grandchildren_category option:selected').data('category');
    var productcategory = document.getElementById('grandchildren_category').value;
    if (productcategory != "---") {
      $('.size_box').val('');
      $('#size_box').css('display', 'block');
    } else {
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
});



  // // サイズ選択欄追加
  // function appendSize(){
  //   const sizeHTML = `<div class="sell-main__form-group" id="sell-main__form-group--size">
  //                     <label for="product_size">サイズ
  //                       <span class="sell-main__form-require">必須</span>
  //                     </label>
  //                     <div class="sell-main__select-wrap">
  //                       <i class="fas fa-chevron-down"></i>
  //                       <select class="sell-main__select-default" name="product[size_id]" id="product_size_id">
  //                         <option value="">--</option>
  //                       </select>
  //                     </div>
  //                     <ul class="sell-main__has-error-text"></ul>
  //                   </div>`;
  //   $(categoryWrapper).parent().after(sizeHTML);
  // }

  // // サイズは必須項目のため、選択欄がないとき用に空のvalueを追加
  // function appendSizeNull(){
  //   const sizeNullHTML = `<div id="sell-main__form-group--size">
  //                           <input type="hidden" name="product[size_id]" value="99"></input>
  //                         </div>`;
  //   $(categoryWrapper).parent().after(sizeNullHTML);
  // }

  // // サイズ選択内容追加
  // function appendSizeOption(size, appendWrap){
  //   let sizeOptionHTML =`<option value="${size.id}">${size.value}</option>`;
  //   $(appendWrap).find('select').append(sizeOptionHTML);
  // }
  // const formBoxDetail = '#sell-main__form-box--detail';

  // // ブランド入力欄追加
  // function appendBrand(){
  //   const brandHTML = `<div class="sell-main__form-group sell-main__form-suggest-container" id="sell-main__form-group--brand">
  //                     <label for="product_brand">ブランド
  //                       <span class="sell-main__form-arbitrary">任意</span>
  //                     </label>
  //                     <div>
  //                       <input class="sell-main__input-default" placeholder="例）シャネル" type="text" name="product[brand]" id="product_brand">
  //                     </div>
  //                     <div></div>
  //                     <ul class="sell-main__has-error-text"></ul>
  //                   </div>`;
  //   $(formBoxDetail).children('div:last-child').before(brandHTML);
  // }

  // // 任意のカテゴリー選択でサイズとブランドの追加
  // $(document).on('change', subSubCategory, function(){
  //   let selectedCategory = $(this).children('select');
  //   let selectedValue = selectedCategory.val();
  //   let selectedOption = selectedCategory.children(`[value="${selectedValue}"]`);
  //   let sizeId = selectedOption.data('size-id');
  //   let brandId = selectedOption.data('brand-id');

  //   $.ajax({
  //     type: "GET",
  //     url: '/api/sell/new',
  //     data: { group: sizeId },
  //     dataType: 'json'
  //   })

  //   .done(function(sizes){
  //     $(sizeWrap).remove();
  //     if(sizeId != '' && sizes[0]){
  //       appendSize();
  //       sizes.forEach(function(size){
  //         appendSizeOption(size, sizeWrap);
  //       });
  //     } else {
  //       appendSizeNull();
  //     }
  //   })
  //   .fail(function(){
  //     alert('カテゴリー検索に失敗しました');
  //   });

  //   $(brandWrap).remove();
  //   if (brandId == '1'){
  //     appendBrand();
  //   }
  // });

  // const deliveryChargeWrap = '#sell-main__form-group--delivery-charge';
  // const deliveryCharge = '#product_delivery_charge_id';
  // const deliveryWayWrap = '#sell-main__form-group--delivery-way';