import I18n from '@ioc:Adonis/Addons/I18n';
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema, rules } from '@ioc:Adonis/Core/Validator'
import Type from 'App/Models/Type';
export default class TypesController {
    public async getAll(ctx: HttpContextContract) {
        const token = await ctx.auth.authenticate();
        const page = ctx.request.input('page', 1)
        const limit = 10
        var result = await Type.query().paginate(page, limit);
        return result;
    }
    public async getById(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var result = await Type.findOrFail(id);
        return result;
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            type: schema.string([
                rules.unique({
                    table: 'types',
                    column: 'type',
                })
            ]),
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'type.required': I18n.locale('ar').formatMessage('types.typeIsRequired'),
                'type.unique': I18n.locale('ar').formatMessage('types.type.unique')
            }
        });
        var type = new Type();
        type.type = fields.type;
        await type.save();
        return { message: "The type has been created!" };

    }
    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
            type: schema.string(),
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'type.required': I18n.locale('ar').formatMessage('types.typeIsRequired'),
            }
        })
        try {
            var id = fields.id;
            var type = await Type.findOrFail(id);
            try {
                await Type.query()
                    .where('type', fields.type)
                    .whereNot('id', fields.id)
                    .firstOrFail()
                return { message: 'type is already in use. ' };
            } catch (error) { }
            type.type = fields.type;
            await type.save();
            return { message: "The type has been updated!" };
        }
        catch (error) {
            return { error: 'Type not found' }
        }
    }
    public async destory(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var type = await Type.findOrFail(id);
        await type.delete();
        return { message: "The type has been deleted!" };
    }
}
