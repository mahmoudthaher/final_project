import I18n from '@ioc:Adonis/Addons/I18n';
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema, rules } from '@ioc:Adonis/Core/Validator'
import Status from 'App/Models/Status';
export default class StatusesController {
    public async getAll(ctx: HttpContextContract) {
        const token = await ctx.auth.authenticate();
        const page = ctx.request.input('page', 1)
        const limit = 10
        var result = await Status.query().paginate(page, limit);
        return result;
    }
    public async getById(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var result = await Status.findOrFail(id);
        return result;
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            status: schema.string([
                rules.unique({
                    table: 'statuses',
                    column: 'status',
                })
            ]),
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'status.required': I18n.locale('ar').formatMessage('statuses.statusIsRequired'),
                'status.unique': I18n.locale('ar').formatMessage('statuses.status.unique')
            }
        });
        var status = new Status();
        status.status = fields.status;
        await status.save();
        return { message: "The status has been created!" };

    }
    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
            status: schema.string(),
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'status.required': I18n.locale('ar').formatMessage('statuses.statusIsRequired'),
            }
        })
        try {
            var id = fields.id;
            var status = await Status.findOrFail(id);
            try {
                await Status.query()
                    .where('status', fields.status)
                    .whereNot('id', fields.id)
                    .firstOrFail()
                return { message: 'status is already in use. ' };

            } catch (error) { }
            status.status = fields.status;
            await status.save();
            return { message: "The status has been updated!" };
        } catch (error) {
            return { error: 'Status not found' }
        }
    }
    public async destory(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var status = await Status.findOrFail(id);
        await status.delete();
        return { message: "The status has been deleted!" };
    }
}
