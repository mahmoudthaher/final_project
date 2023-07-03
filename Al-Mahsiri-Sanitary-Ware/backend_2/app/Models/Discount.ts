import { DateTime } from 'luxon'
import { BaseModel, column } from '@ioc:Adonis/Lucid/Orm'

export default class Discount extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: 'name' })
  public name: string

  @column({ serializeAs: 'description' })
  public description: string

  @column({ serializeAs: 'discount_percent' })
  public discountPercent: number

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime
}
