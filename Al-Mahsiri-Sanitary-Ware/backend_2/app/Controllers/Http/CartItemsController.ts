import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema} from '@ioc:Adonis/Core/Validator'
import CartItem from 'App/Models/CartItem';
export default class CartItemsController {
    public async getAll(ctx: HttpContextContract) {
        const token = await ctx.auth.authenticate();
        var userId = ctx.request.input("user_id");
        var productId = ctx.request.input("product_id");
        var query = CartItem.query().preload('product').preload('user');
        const page = ctx.request.input('page', 1)
        const limit = 10
        if (userId) {
            return query.where("user_id", userId).paginate(page, limit);
        }
        if (productId) {
            return query.where("product_id", productId).paginate(page, limit);
        }
        else
            return await query.paginate(page, limit);
        
    }
    public async getById(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var result = await CartItem.query().preload('product').preload('user').where('id',id);
        return result;
    }
    public async create(ctx: HttpContextContract) {

        const newSchema = schema.create({
            user_id: schema.number(),
            product_id: schema.number(),
            quantity: schema.number(),
            total_price: schema.number(),
        });

        const fields = await ctx.request.validate({ schema: newSchema });
        var cartItem = new CartItem();
        cartItem.userId = fields.user_id;
        cartItem.productId = fields.product_id;
        cartItem.quantity = fields.quantity;
        cartItem.totalPrice = fields.total_price;
        await cartItem.save();
        return { message: "The cart_items has been created!" };
        
    }
    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
            user_id: schema.number(),
            product_id: schema.number(),
            quantity: schema.number(),
            total_price: schema.number(),
        });

        const fields = await ctx.request.validate({ schema: newSchema })
        var id = fields.id;
        var cartItem = await CartItem.findOrFail(id);
        cartItem.userId = fields.user_id;
        cartItem.productId = fields.product_id;
        cartItem.quantity = fields.quantity;
        cartItem.totalPrice = fields.total_price;
        await cartItem.save();
        return { message: "The cart_items has been updated!" };
    }
    public async destory(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var cartItem = await CartItem.findOrFail(id);
        await cartItem.delete();
        return { message: "The cart_item has been deleted!" };
    }
}
