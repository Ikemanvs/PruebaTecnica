$(document).ready(function() {
    getCategories();
    getProducts();

    const modalProducts = document.getElementById('productModal');
    modalProducts.addEventListener('hidden.bs.modal', function(e) {
        $('#productName, #productPrice, #productCat, #idProduct').val('');
        $('#productModal .btn.btn-primary').removeClass('saveProduct');
        $('#productModal .btn.btn-primary').removeClass('editProduct');
    })
});


function getProducts() {
    $.ajax({
        url: '/src/controllers/proccesor.php',
        type: 'post',
        data: {
            spName: 'spC_getProducts',
            params: '',
        },
        success: function(msg) {
            const info = JSON.parse(msg);
            let htmlTable = '';
            for (let index = 0; index < info.length; index++) {
                const element = info[index];
                htmlTable += `
                <tr>
                    <th scope="row">${index + 1}</th>
                    <td>${element.nameProduct}</td>
                    <td>${element.priceProduct}</td>
                    <td>${element.categoryProduct}</td>
                    <td>
                        <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#productModal" data-product="${element.idProduct}"><i class="fa fa-pencil"></i> Edit</button>
                        <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#notifModal" data-product="${element.idProduct}"><i class="fa fa-trash"></i> Delete</button>
                    </td>
                </tr>
                `;
            }
            $('#tableProducts tbody').html(htmlTable);
        }
    })
}

function getCategories() {
    $.ajax({
        url: '/src/controllers/proccesor.php',
        type: 'post',
        data: {
            spName: 'spC_getCategories',
            params: '',
        },
        success: function(msg) {
            const info = JSON.parse(msg);
            let htmlCat = '<option val="" hidden selected>Select one</option>';
            for (let index = 0; index < info.length; index++) {
                const element = info[index];
                htmlCat += `
                <option value="${element.idCat}">${element.nameCat}</option>
                `;
            }
            $('#productCat').html(htmlCat);
        }
    })
}

$(document).on('click', '.btn-warning', function(e) {
    const dataAttr = e.currentTarget.dataset;
    const idProduct = dataAttr.product;

    $('#productModal .btn.btn-primary').addClass('editProduct');

    $.ajax({
        url: '/src/controllers/proccesor.php',
        type: 'post',
        data: {
            spName: 'spC_getProductById',
            params: [idProduct],
        },
        success: function(msg) {
            const info = JSON.parse(msg);
            $('#idProduct').val(idProduct);
            $('#productName').val(info[0]['nameProduct']);
            $('#productPrice').val(info[0]['priceProduct']);
            $('#productCat').val(info[0]['categoryProduct']);
        }
    })
})

$(document).on('click', '.btn-danger', function(e) {
    const dataAttr = e.currentTarget.dataset;
    const idProduct = dataAttr.product;
    $('#notifModal .btn.btn-primary').addClass('deleteProduct');
    $('#notifModal .modal-body').html(`
        <input type="hidden" id="deleteProduct" value="${idProduct}">
        <p>Are you sure you want to delete this product?</p>
    `);
})



$(document).on('click', '#btn-add', function(e) {
    $('#productModal .btn.btn-primary').addClass('saveProduct');
})

$(document).on('click', '.saveProduct', function(e) {
    const nameNewProd = $('#productName').val();
    const priceNewProd = $('#productPrice').val();
    const catNewProd = $('#productCat').val();

    $.ajax({
        url: '/src/controllers/proccesor.php',
        type: 'post',
        data: {
            spName: 'spI_insertProduct',
            params: [nameNewProd, priceNewProd, catNewProd],
        },
        success: function(msg) {
            const info = JSON.parse(msg);
            getProducts();
        }
    })
})

$(document).on('click', '.editProduct', function(e) {
    const idProduct = $('#idProduct').val();
    const nameNewProd = $('#productName').val();
    const priceNewProd = $('#productPrice').val();
    const catNewProd = $('#productCat').val();

    $.ajax({
        url: '/src/controllers/proccesor.php',
        type: 'post',
        data: {
            spName: 'spU_updateProducts',
            params: [idProduct, nameNewProd, priceNewProd, catNewProd],
        },
        success: function(msg) {
            const info = JSON.parse(msg);
            debugger;
            getProducts();
        }
    })
})

$(document).on('click', '.deleteProduct', function(e) {
    const idProduct = $('#deleteProduct').val()
    $.ajax({
        url: '/src/controllers/proccesor.php',
        type: 'post',
        data: {
            spName: 'spU_deleteProduct',
            params: [idProduct],
        },
        success: function(msg) {
            const info = JSON.parse(msg);
            debugger;
            getProducts();
        }
    })
})