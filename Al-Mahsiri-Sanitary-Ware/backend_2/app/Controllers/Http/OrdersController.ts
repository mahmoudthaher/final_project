import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema} from '@ioc:Adonis/Core/Validator'
import auth from 'Config/auth';
import Order from 'App/Models/Order';
import OrderAddress from 'App/Models/OrderAddress';
import OrderProduct from 'App/Models/OrderProduct';
export default class OrdersController {
    public async getAll(ctx: HttpContextContract) {
        const token = await ctx.auth.authenticate();
        
        var result =await Order.query().where("status_id",1).orderBy('id',"asc");
            return result
    }
    public async getById(ctx: HttpContextContract) {
        var userId = ctx.params.userId;
        var result = await Order.query().preload('status').preload('user').where('user_id',userId).orderBy('id',"desc");
        return result;
    }
    
    public async create({ request, response, auth }: HttpContextContract) {

        try {

            var authObject = await auth.authenticate();
            var data = request.all();

            var order = new Order();
            order.userId = authObject.id;
            order.taxAmount = data.tax_amount;
            order.subTotal = data.sub_total;
            order.total = data.total;
            order.paymentMethodId = data.payment_method_id;
            order.statusId=3;
            var newOrder = await order.save();

            var address = new OrderAddress();
            address.country = data.address.country;
            address.city = data.address.city;
            address.area = data.address.area;
            address.street = data.address.street;
            address.buildingNo = data.address.building_no;
            address.longitude = data.address.longitude;
            address.latitude = data.address.latitude;
            address.orderId = newOrder.id;
            await address.save();


            var orderProducts: OrderProduct[] = data.products.map((product) => {
                var orderProduct = new OrderProduct();
                orderProduct.orderId = newOrder.id;
                orderProduct.productId = product.product_id;
                orderProduct.qty = product.qty;
                orderProduct.price = product.price;
                return orderProduct;
            });

            await OrderProduct.createMany(orderProducts);
            return newOrder.toJSON();
        } catch (ex) {
            console.log(ex);
            return response.badRequest({ message: ex });
        }
        
    }
    
    public async destory(ctx: HttpContextContract) {
        const id = ctx.params.id;
      
        
      
        //const user = await User.findOrFail(id);
      
        const orders = await Order.query().where('id', id).preload('orderAddress').preload('orderProducts');
      
        for (const order of orders) {
          for (const orderProduct of order.orderProducts) {
            await orderProduct.delete();
          }
      
          if (order.orderAddress) {
            await order.orderAddress.delete();
          }
      
          await order.delete();
        }
      
        
      
        return { message: "The order has been deleted!" };
        // var id = ctx.params.id;
        // var order = await Order.findOrFail(id);
        // await order.delete();
        // return { message: "The order has been deleted!" };
    }

    public async callOrder(ctx: HttpContextContract) {
        
      
        
        var result =await Order.query().preload("status").preload("user").where("status_id",3).orderBy('id',"asc");
            return result
    }
  
    public async modifyStatusOrder(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
           
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {}
        })
        var id = fields.id;
        var order = await Order.findOrFail(id);
        order.statusId = 1;
        await order.save();
        return { message: "The order status has been updated!" };
    }

}
