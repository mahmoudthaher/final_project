import type { HttpContextContract } from '@ioc:Adonis/Core/HttpContext'
import { schema, rules } from '@ioc:Adonis/Core/Validator'
import User from 'App/Models/User';
import I18n from '@ioc:Adonis/Addons/I18n'
import Hash from '@ioc:Adonis/Core/Hash'
import Mail from '@ioc:Adonis/Addons/Mail';
import Database from '@ioc:Adonis/Lucid/Database';
import Order from 'App/Models/Order';
import OrderAddress from 'App/Models/OrderAddress';
import OrderProduct from 'App/Models/OrderProduct';

//const { firebaseAdmin } = require('firebase-admin');


export default class UsersController {
    public async getAll(ctx: HttpContextContract) {
        const token = await ctx.auth.authenticate();
        var fistName = ctx.request.input("fist_name");
        var lastName = ctx.request.input("last_name");
        var phoneNumber = ctx.request.input("phone_number");
        var email = ctx.request.input("email");
        var userName = ctx.request.input("user_name");
        var address = ctx.request.input("address");
        var genderId = ctx.request.input("gender_id");
        var typeId = ctx.request.input("type_id");
        // var countryId = ctx.request.input("country_id");
        var cityId = ctx.request.input("city_id");
        var query = User.query().preload('city').preload('gender').preload('type');
        const page = ctx.request.input('page', 1);
        const limit = 10;
        if (fistName) {
            return query.where("fist_name", fistName).paginate(page, limit);
        }
        if (lastName) {
            return query.where("last_name", lastName).paginate(page, limit);
        }
        if (phoneNumber) {
            return query.where("phone_number", phoneNumber).paginate(page, limit);
        }
        if (email) {
            return query.where("email", email).paginate(page, limit);
        }
        if (userName) {
            return query.where("user_name", userName).paginate(page, limit);
        }
        if (address) {
            return query.where("address", address).paginate(page, limit);
        }
        if (genderId) {
            return query.where("gender_id", genderId).paginate(page, limit);
        }
        if (typeId) {
            return query.where("type_id", typeId).paginate(page, limit);
        }
        // if (countryId) {
        //     return query.where("country_id", countryId).paginate(page, limit);
        // }
        if (cityId) {
            return query.where("city_id", cityId).paginate(page, limit);
        }
        else
            return await query.paginate(page, limit);
    }
    public async getById(ctx: HttpContextContract) {
        var id = ctx.params.id;
        var result = await User.query().preload('city').preload('gender').preload('type').where('id', id);
        return result;
    }
    public async login(ctx: HttpContextContract) {
        try {
            var object = ctx.request.all();
            var email = object.email;
            var password = object.password;
            var result = await ctx.auth.attempt(email, password);
            // var resultUser = await User.query().where('email',email).orWhere('password',password);
            return result;
        } catch (error) {
            console.log(error)
        }

    }

    public async informationUser(ctx: HttpContextContract) {
        try {
            var email = ctx.params.email;
            var result = User.query().where("email", email);
            return result;
        } catch (error) {
            console.log(error)
        }

        // var object = ctx.request.all();
        // var email = object.email;
        // //var password = object.password;
        // var result = await User.query().where('email',email)//.orWhere('password',password);
        // return result;
    }

    public async logout(ctx: HttpContextContract) {
        var object = await ctx.auth.authenticate();
        await ctx.auth.logout();
        return { message: "Logout" }
    }
    public async create(ctx: HttpContextContract) {

        const newSchema = schema.create({
            fist_name: schema.string(),
            last_name: schema.string({ trim: true }),
            phone_number: schema.string([
                rules.unique({
                    table: 'users',
                    column: 'phone_number',
                })
            ]),
            email: schema.string([
                rules.email(),
                rules.unique({
                    table: 'users',
                    column: 'email',
                })
            ]),

            user_name: schema.string([
                rules.unique({
                    table: 'users',
                    column: 'user_name',
                })
            ]),
            password: schema.string(),
            address: schema.string(),
            gender_id: schema.number(),
            type_id: schema.number(),
            // country_id: schema.number(),
            city_id: schema.number(),
        });

        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'fist_name.required': I18n.locale('ar').formatMessage('users.fistNameIsRequired'),
                'last_name.required': I18n.locale('ar').formatMessage('users.lastNameIsRequired'),
                'phone_number.required': I18n.locale('ar').formatMessage('users.lastNameIsRequired'),
                'phone_number.unique': I18n.locale('ar').formatMessage('users.phoneNumber.unique'),
                'email.required': I18n.locale('ar').formatMessage('users.emailIsRequired'),
                'email.unique': I18n.locale('ar').formatMessage('users.email.unique'),
                'email.email': I18n.locale('ar').formatMessage('users.email.email'),
                'user_name.required': I18n.locale('ar').formatMessage('users.userNameIsRequired'),
                'user_name.unique': I18n.locale('ar').formatMessage('users.userName.unique'),
                'password.required': I18n.locale('ar').formatMessage('users.passwordIsRequired'),
                'address.required': I18n.locale('ar').formatMessage('users.addressIsRequired'),
                'gender_id.required': I18n.locale('ar').formatMessage('users.genderIdIsRequired'),
                'type_id.required': I18n.locale('ar').formatMessage('users.typeIdIsRequired'),
                //  'country_id.required': I18n.locale('ar').formatMessage('users.countryIdIsRequired'),
                'city_id.required': I18n.locale('ar').formatMessage('users.cityIdIsRequired'),
            }
        });
        var user = new User();
        user.fistName = fields.fist_name;
        user.lastName = fields.last_name;
        user.phoneNumber = fields.phone_number;
        user.email = fields.email;
        user.userName = fields.user_name;
        user.password = fields.password;
        user.address = fields.address;
        user.genderId = fields.gender_id;
        user.typeId = fields.type_id;
        // user.countryId = fields.country_id;
        user.cityId = fields.city_id;
        await user.save();
        return { message: "The user has been created!" };
    }
    public async update(ctx: HttpContextContract) {
        const newSchema = schema.create({
            id: schema.number(),
            fist_name: schema.string(),
            last_name: schema.string(),
            phone_number: schema.string(),
            email: schema.string(),
            user_name: schema.string(),
            // password: schema.string(),
            address: schema.string(),
            gender_id: schema.number(),
            type_id: schema.number(),
            // country_id: schema.number(),
            city_id: schema.number(),
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'fist_name.required': I18n.locale('ar').formatMessage('users.fistNameIsRequired'),
                'last_name.required': I18n.locale('ar').formatMessage('users.lastNameIsRequired'),
                'phone_number.required': I18n.locale('ar').formatMessage('users.lastNameIsRequired'),
                'phone_number.unique': I18n.locale('ar').formatMessage('users.phoneNumber.unique'),
                'email.required': I18n.locale('ar').formatMessage('users.emailIsRequired'),
                'email.email': I18n.locale('ar').formatMessage('users.email.email'),
                'user_name.required': I18n.locale('ar').formatMessage('users.userNameIsRequired'),
                'user_name.unique': I18n.locale('ar').formatMessage('users.userName.unique'),
                //'password.required': I18n.locale('ar').formatMessage('users.passwordIsRequired'),
                'address.required': I18n.locale('ar').formatMessage('users.addressIsRequired'),
                'gender_id.required': I18n.locale('ar').formatMessage('users.genderIdIsRequired'),
                'type_id.required': I18n.locale('ar').formatMessage('users.typeIdIsRequired'),
                //   'country_id.required': I18n.locale('ar').formatMessage('users.countryIdIsRequired'),
                'city_id.required': I18n.locale('ar').formatMessage('users.cityIdIsRequired'),
            }
        })
        let errorMessage = ''
        try {
            var id = fields.id;
            var user = await User.findOrFail(id);
            try {
                await User.query()
                    .where('email', fields.email)
                    .whereNot('id', fields.id)
                    .firstOrFail()
                errorMessage += 'Email address is already in use. '
            } catch (error) { }
            try {
                await User.query()
                    .where('phone_number', fields.phone_number)
                    .whereNot('id', fields.id)
                    .firstOrFail()
                errorMessage += 'Phone number is already in use.'
            } catch (error) { }
            try {
                await User.query()
                    .where('user_name', fields.user_name)
                    .whereNot('id', fields.id)
                    .firstOrFail()
                errorMessage += 'User Name is already in use. '
            } catch (error) { }
            if (errorMessage !== '') {
                return { error: errorMessage }
            }
            user.fistName = fields.fist_name;
            user.lastName = fields.last_name;
            user.phoneNumber = fields.phone_number;
            user.email = fields.email;
            user.userName = fields.user_name;
            //user.password = fields.password;
            user.address = fields.address;
            user.genderId = fields.gender_id;
            user.typeId = fields.type_id;
            //  user.countryId = fields.country_id;
            user.cityId = fields.city_id;
            await user.save();
            return { message: "The user has been updated!" };
        }
        catch (error) {
            return { error: 'User not found' }
        }
    }
    public async updatePassword(ctx: HttpContextContract) {

        const newSchema = schema.create({
            id: schema.number(),
            password: schema.string()
        });
        const fields = await ctx.request.validate({
            schema: newSchema,
            messages: {
                'email.required': I18n.locale('ar').formatMessage('users.emailIsRequired'),
                'password.required': I18n.locale('ar').formatMessage('users.passwordIsRequired'),
            }
        })
        var id = fields.id;
        var user = await User.findOrFail(id);
        user.password = fields.password;
        await user.save();
        return { message: "The password has been updated!" };
    }
    public async destroy(ctx: HttpContextContract) {
        const id = ctx.params.id;
      
        
      
        const user = await User.findOrFail(id);
      
        const orders = await Order.query().where('user_id', user.id).preload('orderAddress').preload('orderProducts');
      
        for (const order of orders) {
          for (const orderProduct of order.orderProducts) {
            await orderProduct.delete();
          }
      
          if (order.orderAddress) {
            await order.orderAddress.delete();
          }
      
          await order.delete();
        }
      
        
      
        return { message: "The user and associated records have been deleted!" };
      }
      
      
      
      
    public async checkEmail(ctx: HttpContextContract) {
        var email = ctx.params.email;
        var result = User.query().select('email').where("email", email);
        return result;
    }
    public async checkPhoneNumber(ctx: HttpContextContract) {
        var phoneNumber = ctx.params.phoneNumber;
        var result = User.query().select('phone_number').where("phone_number", phoneNumber);
        return result;
    }
    public async checkUserName(ctx: HttpContextContract) {
        var userName = ctx.params.userName;
        var result = User.query().select('user_name').where("user_name", userName);
        return result;
    }
    public async checkUserAndPhone(ctx: HttpContextContract) {
        var email = ctx.request.input('email')
        var phoneNumber = ctx.request.input('phone_number');
        var result = User.query().select("id").where("email", email).andWhere("phone_number", phoneNumber);
        return result;
    }

    public async sendEmail(ctx: HttpContextContract) {
        try {
            const newSchema = schema.create({
                email: schema.string(),
                firstName: schema.string(),
            });
            const fields = await ctx.request.validate({
                schema: newSchema
            })
            const randomatic = require('randomatic');
            const randomFourDigitNumber = randomatic('0', 4).toString()


            var email = fields.email;
            Mail.send((message) => {
                message
                    .from('vreify@adonis.com')
                    .to(email)
                    .subject(randomFourDigitNumber)
                    .htmlView('emails/verify', { email })
            })
        } catch (error) {
            return error
        }
    }
    public async getUserByTypeIdSub() {
        
        var result = await User.query().where('type_id', 1);
        return result;
    }

    public async getUserByTypeIdBase() {
        
        var result = await User.query().where('type_id', 2).whereNot("id",41);
        return result;
    }


    // public async resetPassword({ request, response }) {
    //     const { email, newPassword } = request.only(['email', 'newPassword']);

    //     try {
    //         // Get the user from your own database based on the email
    //         const user = await User.findBy('email', email);

    //         if (!user) {
    //             return response.status(404).json({
    //                 message: 'User not found'
    //             });
    //         }

    //         // Update the user's password in your own database
    //         user.password = await Hash.make(newPassword);
    //         await user.save();

    //         // Use the Firebase Admin SDK to update the user's password in Firebase Authentication
    //         await firebaseAdmin.auth().updateUser(user.id, {
    //             password: newPassword
    //         });

    //         return response.json({
    //             message: 'Password updated successfully'
    //         });
    //     } catch (error) {
    //         console.error(error);
    //         return response.status(500).json({
    //             message: 'Failed to update password'
    //         });
    //     }


    //}



    //const User = use('App/Models/User')
    //const Hash = use('Hash')


    // public async resetPassword({ request, response }) {
    //     const { password } = request.all()

    //     try {
    //         // You may have your own logic to find the user, such as finding by email
    //         const user = await User.findBy('email', "mthaher3@gmail.com")

    //         if (!user) {
    //             return response.status(400).json({ message: 'User not found' })
    //         }

    //         // Hash the new password
    //         const hashedPassword = await Hash.make(password)

    //         // Update the user's password
    //         user.password = hashedPassword
    //         await user.save()

    //         return response.status(200).json({ message: 'Password reset successful' })
    //     } catch (error) {
    //         return response.status(500).json({ message: 'Internal server error' })
    //     }
    // }





}

