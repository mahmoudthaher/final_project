import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema} from '@ioc:Adonis/Core/Validator'
import Payment from 'App/Models/Payment';
export default class PaymentsController {
    public async getAll(ctx: HttpContextContract) {
        const token = await ctx.auth.authenticate();
        var userId = ctx.request.input("user_id");
        var paymentDate = ctx.request.input("payment_date");
        var query = Payment.query().preload('user');
        const page = ctx.request.input('page', 1)
        const limit = 10
        if (userId) {
            return query.where("user_id", userId).paginate(page, limit);
        }
        if (paymentDate) {
            return query.where("payment_date", paymentDate).paginate(page, limit);
        }
        else
            return await query.paginate(page, limit);
    }
    public async getById(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var result = await Payment.query().preload('user').where('id',id);
        return result;
    }
    public async create(ctx: HttpContextContract) {

        const newSchema = schema.create({
            user_id: schema.number(),
            amount: schema.number(),
        });

        const fields = await ctx.request.validate({ schema: newSchema });
        var payment = new Payment();
        payment.userId = fields.user_id;
        payment.amount = fields.amount;
        await payment.save();
        return { message: "The payment has been created!" };
        
    }
    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
            user_id: schema.number(),
            amount: schema.number(),
        });

        const fields = await ctx.request.validate({ schema: newSchema })
        var id = fields.id;
        var payment = await Payment.findOrFail(id);
        payment.userId = fields.user_id;
        payment.amount = fields.amount;
        await payment.save();
        return { message: "The payment has been updated!" };
    }
    public async destory(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var payment = await Payment.findOrFail(id);
        await payment.delete();
        return { message: "The payment has been deleted!" };
    }
}
