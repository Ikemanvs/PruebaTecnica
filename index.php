<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/src/css/libs/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/src/css/libs/datatables/datatables.min.css">
    <link rel="stylesheet" href="/src/css/main.css?v=<?= rand() ?>">
    <title>Document</title>
</head>

<body>
    <?php include 'src/includes/nav.php' ?>
    <section class="container custom-top">
        <div class="row">
            <div class="col col-6">
                <h1>Product inventory</h1>
            </div>
            <div class="col col-6">
                <button type="button" id="btn-add" class="btn btn-primary d-flex align-items-center justify-content-center mx-auto"
                    data-bs-toggle="modal" data-bs-target="#productModal">
                    Add a new product
                </button>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <table class="table" id="tableProducts">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">Price</th>
                            <th scope="col">Category</th>
                            <th scope="col">Options</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <div class="modal fade" id="productModal" tabindex="-1" aria-labelledby="productModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="productModalLabel">Product information</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form>
                        <input type="hidden" id="idProduct">
                        <div class="mb-3">
                            <label for="productName" class="form-label">Name</label>
                            <input type="text" class="form-control" id="productName" aria-describedby="productName">
                        </div>
                        <div class="mb-3">
                            <label for="productPrice" class="form-label">Price</label>
                            <input type="text" class="form-control" id="productPrice" aria-describedby="productPrice">
                        </div>
                        <div class="mb-3">
                            <label for="productCat" class="form-label">Category</label>
                            <select type="text" class="form-select" id="productCat" aria-describedby="productCat"></select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="notifModal" tabindex="-1" aria-labelledby="notifModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="notifModalLabel">Information</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Confirm</button>
                </div>
            </div>
        </div>
    </div>
</body>
<footer>
    <script src="/src/js/libs/bootstrap/bootstrap.min.js"></script>
    <script src="/src/js/libs/jquery/jquery-3.7.1.min.js"></script>
    <script src="/src/js/libs/datatables/datatables.min.js"></script>
    <script src="https://kit.fontawesome.com/6d43cac60a.js" crossorigin="anonymous"></script>
    <script src="/src/js/main.js?v=<?= rand() ?>"></script>
</footer>

</html>