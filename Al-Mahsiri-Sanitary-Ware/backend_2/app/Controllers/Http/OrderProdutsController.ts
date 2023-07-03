import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import OrderProduct from 'App/Models/OrderProduct';

export default class OrderProdutsController {
    public async getByOrderId(ctx: HttpContextContract) {
        try {
            var orderId = ctx.params.orderId;
            var result = await OrderProduct.query().preload("order").preload("product").where("order_id", orderId);
            return result;
        } catch (error) {
            console.log(error);
        }

    }
}
