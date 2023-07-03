import { DateTime } from 'luxon'
import { column, BaseModel, belongsTo, BelongsTo } from '@ioc:Adonis/Lucid/Orm'
import Order from './Order'
import Product from './Product'

export default class OrderProduct extends BaseModel {
    @column({ isPrimary: true })
    public id: number

    @column({ serializeAs: "order_id" })
    public orderId: number

    @column({ serializeAs: "product_id" })
    public productId: number

    @column({ serializeAs: "qty" })
    public qty: number

    @column({ serializeAs: "price" })
    public price: number

    @column.dateTime({ autoCreate: true })
    public createdAt: DateTime

    @column.dateTime({ autoCreate: true, autoUpdate: true })
    public updatedAt: DateTime

    @belongsTo(() => Order, {
        foreignKey: 'orderId',
      })
      public order: BelongsTo<typeof Order>

      @belongsTo(() => Product, {
        foreignKey: 'productId',
      })
      public product: BelongsTo<typeof Product>


}