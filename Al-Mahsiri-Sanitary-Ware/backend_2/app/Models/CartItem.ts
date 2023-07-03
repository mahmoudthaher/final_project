import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, belongsTo, column } from '@ioc:Adonis/Lucid/Orm'
import User from './User'
import Product from './Product'

export default class CartItem extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: 'user_id' })
  public userId: number

  @column({ serializeAs: 'product_id' })
  public productId: number

  @column({ serializeAs: 'quantity' })
  public quantity: number

  @column({ serializeAs: 'total_price' })
  public totalPrice: number

  @column.dateTime({ autoCreate: true })
  public createdAt: DateTime

  @column.dateTime({ autoCreate: true, autoUpdate: true })
  public updatedAt: DateTime

  @belongsTo(() => User, {
    foreignKey: 'userId',
  })
  public user: BelongsTo<typeof User>

  @belongsTo(() => Product, {
    foreignKey: 'productId',
  })
  public product: BelongsTo<typeof Product>
}
