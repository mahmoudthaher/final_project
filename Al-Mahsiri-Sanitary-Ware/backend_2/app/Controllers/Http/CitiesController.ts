import I18n from '@ioc:Adonis/Addons/I18n';
import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema, rules } from '@ioc:Adonis/Core/Validator'
import City from 'App/Models/City';
export default class CitiesController {
    public async getAll(ctx: HttpContextContract) {
        
        var city = ctx.request.input("city");
        var query = City.query()
        if (city) {
            return query.where("city", city);
        }
        else
            return query;

    }
    public async getById(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var result = await  City.findOrFail(id);
        return result;
    }
    public async create(ctx: HttpContextContract) {
        const newSchema = schema.create({
            city: schema.string([
                rules.unique({
                    table: 'cities',
                    column: 'City',
                })
            ]),
          //  country_id:schema.number()
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'city.required': I18n.locale('ar').formatMessage('cities.cityIsRequired'),
                'city.unique': I18n.locale('ar').formatMessage('cities.city.unique'),
               // 'country_id.required': I18n.locale('ar').formatMessage('cities.countryIdIsRequired'),
            }
        });
        var city = new City();
        city.city = fields.city;
      //  city.countryId=fields.country_id;
        await city.save();
        return { message: "The city has been created!" };
    }
    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
            city: schema.string(),
          //  country_id:schema.number()
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'city.required': I18n.locale('ar').formatMessage('cities.cityIsRequired'),
                //'country_id.required': I18n.locale('ar').formatMessage('cities.countryIdIsRequired'),
            }
        })

        try {
            var id = fields.id;
            var city = await City.findOrFail(id);
            try {
                await City.query()
                .where('city', fields.city)
                .whereNot('id', fields.id)
                .firstOrFail()
            return { message: 'city is already in use. ' };
            } catch (error) {}
            city.city = fields.city;
            //city.countryId=fields.country_id;
            await city.save();
            return { message: "The city has been updated!" };
        } catch (error) {
            return { error: 'City not found' }
        }
    }
    public async destory(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var city = await City.findOrFail(id);
        await city.delete();
        return { message: "The city has been deleted!" };
    }
}
