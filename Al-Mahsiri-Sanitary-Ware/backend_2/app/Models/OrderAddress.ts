import { DateTime } from 'luxon'
import { column, BaseModel, BelongsTo, belongsTo } from '@ioc:Adonis/Lucid/Orm'
import Order from './Order'

export default class OrderAddress extends BaseModel {
    @column({ isPrimary: true })
    public id: number

    @column({ serializeAs: "order_id" })
    public orderId: number

    @column({ serializeAs: "longitude" })
    public longitude: number

    @column({ serializeAs: "latitude" })
    public latitude: number

    @column({ serializeAs: "city" })
    public city: String

    @column({ serializeAs: "country" })
    public country: String

    @column({ serializeAs: "area" })
    public area: String

    @column({ serializeAs: "street" })
    public street: String

    @column({ serializeAs: "building_no" })
    public buildingNo: String

    @column.dateTime({ autoCreate: true })
    public createdAt: DateTime

    @column.dateTime({ autoCreate: true, autoUpdate: true })
    public updatedAt: DateTime

    @belongsTo(() => Order, {
        foreignKey: 'orderId',
      })
      public order: BelongsTo<typeof Order>

}