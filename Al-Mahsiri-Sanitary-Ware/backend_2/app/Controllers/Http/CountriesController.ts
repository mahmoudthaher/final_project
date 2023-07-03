import I18n from '@ioc:Adonis/Addons/I18n';
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema, rules } from '@ioc:Adonis/Core/Validator'
import Country from 'App/Models/Country';
export default class CountriesController {
    public async getAll(ctx: HttpContextContract) {
        const token = await ctx.auth.authenticate();
        var country = ctx.request.input("country");
        var query = Country.query();
        const page = ctx.request.input('page', 1)
        const limit = 10
        if (country) {
            return query.where("country", country).paginate(page, limit);
        }
        else
            return query.paginate(page, limit);
    }
    public async getById(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var result = await Country.findOrFail(id);
        return result;
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            country: schema.string([
                rules.unique({
                    table: 'countries',
                    column: 'Country',
                })
            ]),
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'country.required': I18n.locale('ar').formatMessage('countries.countryIsRequired'),
                'country.unique': I18n.locale('ar').formatMessage('countries.country.unique')
            }
        });
        var country = new Country();
        country.country = fields.country;
        await country.save();
        return { message: "The country has been created!" };
    }
    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
            country: schema.string(),
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'country.required': I18n.locale('ar').formatMessage('countries.countryIsRequired'),
            }
        })
        try {
            var id = fields.id;
            var country = await Country.findOrFail(id);
            try {
                await Country.query()
                    .where('country', fields.country)
                    .whereNot('id', fields.id)
                    .firstOrFail()
                return { message: 'country is already in use. ' };
            } catch (error) {}
            country.country = fields.country;
            await country.save();
            return { message: "The country has been updated!" };
        } catch (error) {
            return { error: 'Country not found' }
        }
    }
    public async destory(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var country = await Country.findOrFail(id);
        await country.delete();
        return { message: "The country has been deleted!" };
    }
}
