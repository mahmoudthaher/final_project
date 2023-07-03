import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column, hasMany, HasOne, hasOne, ManyToMany, manyToMany } from '@ioc:Adonis/Lucid/Orm'
import Country from './Country'
export default class City extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: 'city' })
  public city: string

  // @column({ serializeAs: 'country_id' })
  // public countryId: number

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  // @belongsTo(() => Country, {
  //   foreignKey: 'countryId'
  // })
  // public country: BelongsTo<typeof Country>
}
