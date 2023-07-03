import { DateTime } from 'luxon'
import { BaseModel, beforeSave, beforeUpdate, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Gender from './Gender'
import Type from './Type'
import City from './City'
import Hash from '@ioc:Adonis/Core/Hash'

export default class User extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: 'fist_name' })
  public fistName: string

  @column({ serializeAs: 'last_name' })
  public lastName: string

  @column({ serializeAs: 'phone_number' })
  public phoneNumber: string

  @column()
  public email: string

  @column({ serializeAs: 'user_name' })
  public userName: string

  @column({ serializeAs: 'password' })
  public password: string

  @column({ serializeAs: 'address' })
  public address: string

  @column({ serializeAs: 'gender_id' })
  public genderId: number

  @column({ serializeAs: 'type_id' })
  public typeId: number

  // @column({ serializeAs: 'country_id' })
  // public countryId: number

  @column({ serializeAs: 'city_id' })
  public cityId: number

  @column()
  public rememberMeToken: string | null

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(() => Gender, {
    foreignKey: 'genderId',
  })
  public gender: BelongsTo<typeof Gender>

  @belongsTo(() => Type, {
    foreignKey: 'typeId',
  })
  public type: BelongsTo<typeof Type>

  // @belongsTo(() => Country, {
  //   foreignKey: 'countryId',
  // })
  // public country: BelongsTo<typeof Country>

  @belongsTo(() => City, {
    foreignKey: 'cityId',
  })
  public city: BelongsTo<typeof City>

  @beforeSave()
  public static async hashPassword (user: User) {
    if (user.$dirty.password) {
      user.password = await Hash.make(user.password)
    }
  }
 
}
