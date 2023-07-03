import { DateTime } from 'luxon'
import { BaseModel, BelongsTo, HasMany, HasOne, belongsTo, column, hasMany, hasOne } from '@ioc:Adonis/Lucid/Orm'
import User from './User'
import Product from './Product'
import Status from './Status'
import OrderAddress from './OrderAddress'
import OrderProduct from './OrderProduct'

export default class Order extends BaseModel {
  @column({ isPrimary: true })
  public id: number

  @column({ serializeAs: "user_id" })
  public userId: number

  @column({ serializeAs: 'total' })
  public total: number

  @column({ serializeAs: "sub_total" })
    public subTotal: number

  @column({ serializeAs: "tax_amount" })
    public taxAmount: number

  @column({ serializeAs: "payment_method_id" })
    public paymentMethodId: number

  @column({ serializeAs: 'status_id' })
  public statusId: number

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
  
@hasOne(() => OrderAddress, {
  foreignKey: 'orderId',
})
public orderAddress: HasOne<typeof OrderAddress>

@hasMany(() => OrderProduct, {
  foreignKey: 'orderId',
})
public orderProducts: HasMany<typeof OrderProduct>

  @belongsTo(() => Status, {
    foreignKey: 'statusId',
  })
  
  public status: BelongsTo<typeof Status> 
    
   
}
