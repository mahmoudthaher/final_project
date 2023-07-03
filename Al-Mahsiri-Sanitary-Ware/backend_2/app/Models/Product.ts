import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import Category from './Category'
import Discount from './Discount'

export default class Product extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: 'name' })
  public name: string

  // @column({ serializeAs: 'description' })
  // public description: string

  @column({ serializeAs: 'price' })
  public price: number

  @column({ serializeAs: 'quantity_in_stock' })
  public quantityInStock: number

  @column({ serializeAs: 'image' })
  public image: string

  @column({ serializeAs: 'category_id' })
  public categoryId: number

  @column({ serializeAs: 'discount_id' })
  public discountId: number

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(() => Category, {
    foreignKey: 'categoryId',
  })
  public category: BelongsTo<typeof Category>

  @belongsTo(() => Discount, {
    foreignKey: 'discountId',
  })
  public discount: BelongsTo<typeof Discount>
}
