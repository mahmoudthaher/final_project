import Route from '@ioc:Adonis/Core/Route'
Route.group(() => {
  Route.group(() => {
    Route.get("/:id", "CartItemsController.getById");
    Route.get("/", "CartItemsController.getAll");
    Route.post("/", "CartItemsController.create");
    Route.put("/", "CartItemsController.update");
    Route.delete("/:id", "CartItemsController.destory");
  }).prefix("/CartItems");
  Route.group(() => {
    Route.get("/category/:category", "CategoriesController.checkCategory");
    Route.get("/:id", "CategoriesController.getById");
    Route.get("/", "CategoriesController.getAll");
    Route.post("/", "CategoriesController.create");
    Route.put("/", "CategoriesController.update");
    Route.delete("/:id", "CategoriesController.destory");
  }).prefix("/Categories");
  Route.group(() => {
    Route.get("/:id", "CitiesController.getById");
    Route.get("/", "CitiesController.getAll");
    Route.post("/", "CitiesController.create");
    Route.put("/", "CitiesController.update");
    Route.delete("/:id", "CitiesController.destory");
  }).prefix("/Cities");
  Route.group(() => {
    Route.get("/:id", "CountriesController.getById");
    Route.get("/", "CountriesController.getAll");
    Route.post("/", "CountriesController.create");
    Route.put("/", "CountriesController.update");
    Route.delete("/:id", "CountriesController.destory");
  }).prefix("/Countries");
  Route.group(() => {
    Route.get("/:id", "DiscountsController.getById");
    Route.get("/", "DiscountsController.getAll");
    Route.post("/", "DiscountsController.create");
    Route.put("/", "DiscountsController.update");
    Route.delete("/:id", "DiscountsController.destory");
  }).prefix("/Discounts");
  Route.group(() => {
    Route.get("/:id", "GendersController.getById");
    Route.get("/", "GendersController.getAll");
    Route.post("/", "GendersController.create");
    Route.put("/", "GendersController.update");
    Route.delete("/:id", "GendersController.destory");
  }).prefix("/Genders");
  Route.group(() => {
    Route.get("/callOrder", "OrdersController.callOrder");
    Route.get("/:userId", "OrdersController.getById");
    Route.get("/", "OrdersController.getAll");
    Route.post("/", "OrdersController.create");
    Route.put("/modifyStatusOrder", "OrdersController.modifyStatusOrder");
    Route.put("/", "OrdersController.update");
    Route.delete("/:id", "OrdersController.destory");
  }).prefix("/Orders");
  Route.group(() => {
    Route.get("/:orderId", "OrderProdutsController.getByOrderId");
  }).prefix("/OrderProduts");
  Route.group(() => {
    Route.get("/:id", "PaymentsController.getById");
    Route.get("/", "PaymentsController.getAll");
    Route.post("/", "PaymentsController.create");
    Route.put("/", "PaymentsController.update");
    Route.delete("/:id", "PaymentsController.destory");
  }).prefix("/Payments");
  Route.group(() => {
    Route.get("/product/:name", "ProductsController.checkProduct");
    Route.get("/fliterProduct/:name", "ProductsController.fliterProduct");
    Route.get("/productID/:id", "ProductsController.getById");
    Route.get("/:categoryId", "ProductsController.getBycategoryId");
    Route.get("/", "ProductsController.getAll");
    Route.post("/", "ProductsController.create");
    Route.put("/", "ProductsController.update");
    Route.delete("/:id", "ProductsController.destory");
  }).prefix("/Products");
  Route.group(() => {
    Route.get("/:id", "StatusesController.getById");
    Route.get("/", "StatusesController.getAll");
    Route.post("/", "StatusesController.create");
    Route.put("/", "StatusesController.update");
    Route.delete("/:id", "StatusesController.destory");
  }).prefix("/Statuses");
  Route.group(() => {
    Route.get("/:id", "TypesController.getById");
    Route.get("/", "TypesController.getAll");
    Route.post("/", "TypesController.create");
    Route.put("/", "TypesController.update");
    Route.delete("/:id", "TypesController.destory");
  }).prefix("/Types");
  Route.group(() => {
    
    Route.get("/informationUser/:email", "UsersController.informationUser");
    Route.get("/username/:userName", "UsersController.checkUserName");
    Route.get("/phonenumber/:phoneNumber", "UsersController.checkPhoneNumber");
    Route.get("/email/:email", "UsersController.checkEmail");
    Route.get("/BaseAdmin/", "UsersController.getUserByTypeIdBase");
    Route.get("/SubAdmin/", "UsersController.getUserByTypeIdSub");
    Route.get("/:id", "UsersController.getById");
    Route.get("/", "UsersController.getAll");
  // Route.post('/password/reset', 'UsersController.resetPassword');
    Route.post("/sendEmail", "UsersController.sendEmail");
    Route.post("/login", "UsersController.login");
    Route.post("/logout", "UsersController.logout");
    Route.post("/checkUserAndPhone", "UsersController.checkUserAndPhone");
    Route.post("/", "UsersController.create");
    Route.put("/updatePassword", "UsersController.updatePassword");
    Route.put("/", "UsersController.update");
    Route.delete("/:id", "UsersController.destroy");
  }).prefix("/Users");
  Route.group(() => {
   
    Route.delete("/:id", "ApiTokenController.destory");
  }).prefix("/ApiToken");
}).prefix("api")