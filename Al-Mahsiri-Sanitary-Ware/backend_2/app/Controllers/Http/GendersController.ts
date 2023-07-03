import I18n from '@ioc:Adonis/Addons/I18n';
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema, rules } from '@ioc:Adonis/Core/Validator'
import Gender from 'App/Models/Gender';
export default class GendersController {
    public async getAll(ctx: HttpContextContract) {
        const token = await ctx.auth.authenticate();
        const page = ctx.request.input('page', 1)
        const limit = 10
        var result = await Gender.query().paginate(page, limit);
        return result;
    }
    public async getById(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var result = await Gender.findOrFail(id);
        return result;
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            gender: schema.string([
                rules.unique({
                    table: 'genders',
                    column: 'gender',
                })
            ]),
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'gender.required': I18n.locale('ar').formatMessage('genders.genderIsRequired'),
                'gender.unique': I18n.locale('ar').formatMessage('genders.gender.unique')
            }
        });
        var gender = new Gender();
        gender.gender = fields.gender;
        await gender.save();
        return { message: "The gender has been created!" };
    }
    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
            gender: schema.string(),
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'gender.required': I18n.locale('ar').formatMessage('genders.genderIsRequired'),
            }
        })
        try {
            var id = fields.id;
            var gender = await Gender.findOrFail(id);
            try {
                await Gender.query()
                    .where('gender', fields.gender)
                    .whereNot('id', fields.id)
                    .firstOrFail()
                return { message: 'gender is already in use. ' };
            } catch (error) { }
            gender.gender = fields.gender;
            await gender.save();
            return { message: "The gender has been updated!" };
        } catch (error) {
            return { error: 'Gender not found' }
        }
    }
    public async destory(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var gender = await Gender.findOrFail(id);
        await gender.delete();
        return { message: "The gender has been deleted!" };
    }
}
