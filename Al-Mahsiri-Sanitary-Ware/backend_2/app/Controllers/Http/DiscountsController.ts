import I18n from '@ioc:Adonis/Addons/I18n';
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import {schema,rules} from '@ioc:Adonis/Core/Validator'
import Discount from 'App/Models/Discount';
export default class DiscountsController {
    public async getAll(ctx: HttpContextContract) {
        const token = await ctx.auth.authenticate();
        var name = ctx.request.input("name");
        var discountPercent = ctx.request.input("discount_percent");
        var query = Discount.query();
        const page = ctx.request.input('page', 1)
        const limit = 10
        if (name) {
            return query.where("name", name).paginate(page, limit);
        }
        if (discountPercent) {
            return query.where("discount_percent", discountPercent).paginate(page, limit);
        }
        else
            return query.paginate(page, limit);
    }
    public async getById(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var result = await Discount.findOrFail(id);
        return result;
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            name: schema.string([
                rules.unique({
                    table: 'discounts',
                    column: 'name',
                })
            ]),
            description: schema.string(),
            discount_percent: schema.number(),
        });
        const fields = await ctx.request.validate({ schema: newSchema,
            messages:{
                'name.required':I18n.locale('ar').formatMessage('discounts.nameIsRequired'),
                'name.unique':I18n.locale('ar').formatMessage('discounts.name.unique'),
                'description.required':I18n.locale('ar').formatMessage('discounts.descriptionIsRequired'),
                'discount_percent.required':I18n.locale('ar').formatMessage('discounts.discountPercentIsRequired'),
                'discount_percent.number':I18n.locale('ar').formatMessage('discounts.discountPercent.number'),
            } });
        var discount = new Discount();
        discount.name = fields.name;
        discount.description = fields.description;
        discount.discountPercent = fields.discount_percent;
        await discount.save();
        return { message: "The discount has been created!" };
    }
    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
            name: schema.string(),
            description: schema.string(),
            discount_percent: schema.number(),
        });
        const fields = await ctx.request.validate({ schema: newSchema })
        var id = fields.id;
        var discount = await Discount.findOrFail(id);
        discount.name = fields.name;
        discount.description = fields.description;
        discount.discountPercent = fields.discount_percent;
        await discount.save();
        return { message: "The discount has been updated!" };
    }
    public async destory(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var discount = await Discount.findOrFail(id);
        await discount.delete();
        return { message: "The discount has been deleted!" };
    }
}
