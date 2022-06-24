//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let customer = try? newJSONDecoder().decode(Customer.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Customer
//struct ProfileCustomer: Codable {
//    var orders: [ProfileOrder]?
//
//    init(response : [String : Any]?){
//        guard let response = response else {
//            print("failed To initialize \(String(describing: self))")
//            return
//        }
//        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
//            if let responseData = try? JSONDecoder().decode(ProfileCustomer.self, from: date){
//                self.orders = responseData.orders
//            }
//        }
//    }
//}
//
//// MARK: - Order
//struct ProfileOrder: Codable {
//    let id: Int
//    let adminGraphqlAPIID: String
//    let appID: Int
//    let browserIP: String?
//    let buyerAcceptsMarketing: Bool
//    let cancelReason, cancelledAt, cartToken, checkoutID: String?
//    let checkoutToken, closedAt: String?
//    let confirmed: Bool
//    let contactEmail: String
//    let createdAt: Date
//    let currency: String
//    let currentSubtotalPrice: String
//    let currentSubtotalPriceSet: String
//    let currentTotalDiscounts: String
//    let currentTotalDiscountsSet: String
//    let currentTotalDutiesSet: String?
//    let currentTotalPrice: String
//    let currentTotalPriceSet: String
//    let currentTotalTax: String
//    let currentTotalTaxSet: String
//    let customerLocale, deviceID: String?
//    let discountCodes: [String]
//    let email: String
//    let estimatedTaxes: Bool
//    let financialStatus: String
//    let fulfillmentStatus: String?
//    let gateway: String
//    let landingSite, landingSiteRef, locationID: String?
//    let name: String
//    let note: String?
//    let noteAttributes: [String]
//    let number, orderNumber: Int
//    let orderStatusURL: String
//    let originalTotalDutiesSet: String?
//    let paymentGatewayNames: [String]
//    let phone: String?
//    let presentmentCurrency: String
//    let processedAt: Date
//    let processingMethod: String
//    let reference, referringSite, sourceIdentifier: String?
//    let sourceName: String
//    let sourceURL: String?
//    let subtotalPrice: String
//    let subtotalPriceSet: String
//    let tags: String
//    let taxLines: [String]
//    let taxesIncluded, test: Bool
//    let token, totalDiscounts: String
//    let totalDiscountsSet: String
//    let totalLineItemsPrice: String
//    let totalLineItemsPriceSet: String
//    let totalOutstanding, totalPrice: String
//    let totalPriceSet: String
//    let totalPriceUsd: String
//    let totalShippingPriceSet: String
//    let totalTax: String
//    let totalTaxSet: String
//    let totalTipReceived: String
//    let totalWeight: Int
//    let updatedAt: Date
//    let userID: String?
//    let customer: CustomerClass
//    let discountApplications, fulfillments: [String]
//    let lineItems: [LineItem]
//    let paymentTerms: String?
//    let refunds, shippingLines: [String]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case adminGraphqlAPIID = "admin_graphql_api_id"
//        case appID = "app_id"
//        case browserIP = "browser_ip"
//        case buyerAcceptsMarketing = "buyer_accepts_marketing"
//        case cancelReason = "cancel_reason"
//        case cancelledAt = "cancelled_at"
//        case cartToken = "cart_token"
//        case checkoutID = "checkout_id"
//        case checkoutToken = "checkout_token"
//        case closedAt = "closed_at"
//        case confirmed
//        case contactEmail = "contact_email"
//        case createdAt = "created_at"
//        case currency
//        case currentSubtotalPrice = "current_subtotal_price"
//        case currentSubtotalPriceSet = "current_subtotal_price_set"
//        case currentTotalDiscounts = "current_total_discounts"
//        case currentTotalDiscountsSet = "current_total_discounts_set"
//        case currentTotalDutiesSet = "current_total_duties_set"
//        case currentTotalPrice = "current_total_price"
//        case currentTotalPriceSet = "current_total_price_set"
//        case currentTotalTax = "current_total_tax"
//        case currentTotalTaxSet = "current_total_tax_set"
//        case customerLocale = "customer_locale"
//        case deviceID = "device_id"
//        case discountCodes = "discount_codes"
//        case email
//        case estimatedTaxes = "estimated_taxes"
//        case financialStatus = "financial_status"
//        case fulfillmentStatus = "fulfillment_status"
//        case gateway
//        case landingSite = "landing_site"
//        case landingSiteRef = "landing_site_ref"
//        case locationID = "location_id"
//        case name, note
//        case noteAttributes = "note_attributes"
//        case number
//        case orderNumber = "order_number"
//        case orderStatusURL = "order_status_url"
//        case originalTotalDutiesSet = "original_total_duties_set"
//        case paymentGatewayNames = "payment_gateway_names"
//        case phone
//        case presentmentCurrency = "presentment_currency"
//        case processedAt = "processed_at"
//        case processingMethod = "processing_method"
//        case reference
//        case referringSite = "referring_site"
//        case sourceIdentifier = "source_identifier"
//        case sourceName = "source_name"
//        case sourceURL = "source_url"
//        case subtotalPrice = "subtotal_price"
//        case subtotalPriceSet = "subtotal_price_set"
//        case tags
//        case taxLines = "tax_lines"
//        case taxesIncluded = "taxes_included"
//        case test, token
//        case totalDiscounts = "total_discounts"
//        case totalDiscountsSet = "total_discounts_set"
//        case totalLineItemsPrice = "total_line_items_price"
//        case totalLineItemsPriceSet = "total_line_items_price_set"
//        case totalOutstanding = "total_outstanding"
//        case totalPrice = "total_price"
//        case totalPriceSet = "total_price_set"
//        case totalPriceUsd = "total_price_usd"
//        case totalShippingPriceSet = "total_shipping_price_set"
//        case totalTax = "total_tax"
//        case totalTaxSet = "total_tax_set"
//        case totalTipReceived = "total_tip_received"
//        case totalWeight = "total_weight"
//        case updatedAt = "updated_at"
//        case userID = "user_id"
//        case customer
//        case discountApplications = "discount_applications"
//        case fulfillments
//        case lineItems = "line_items"
//        case paymentTerms = "payment_terms"
//        case refunds
//        case shippingLines = "shipping_lines"
//    }
//
//    init(response : [String : Any]?){
//        guard let response = response else {
//            print("failed To initialize \(String(describing: self))")
//            return
//        }
//        if let date  = try? JSONSerialization.data(withJSONObject: response, options: []){
//            if let responseData = try? JSONDecoder().decode(ProfileOrder.self, from: date){
//                self.id = responseData.id
//                self.adminGraphqlAPIID = responseData.adminGraphqlAPIID
//                self.appID = responseData.appID
//                self.browserIP = responseData.browserIP
//                self.buyerAcceptsMarketing = responseData.buyerAcceptsMarketing
//                self.cancelReason = responseData.cancelReason
//                self.cancelledAt = responseData.cancelledAt
//                self.cartToken = responseData.cartToken
//                self.closedAt = responseData.closedAt
//                self.checkoutID = responseData.checkoutID
//                self.confirmed = responseData.confirmed
//                self.contactEmail = responseData.contactEmail
//                self.createdAt = responseData.createdAt
//                self.currency = responseData.currency
//                self.currentSubtotalPrice = responseData.currentSubtotalPrice
//                self.currentSubtotalPriceSet = responseData.currentSubtotalPriceSet
//                self.currentTotalDiscounts = responseData.currentTotalDiscounts
//                self.currentTotalDiscountsSet = responseData.currentTotalDiscountsSet
//                self.currentTotalDutiesSet = responseData.currentTotalDutiesSet
//                self.currentTotalPrice = responseData.currentTotalPrice
//                self.currentTotalPriceSet = responseData.currentTotalPriceSet
//                self.currentTotalTax = responseData.currentTotalTax
//                self.currentTotalTaxSet = responseData.currentTotalTaxSet
//                self.customerLocale = responseData.customerLocale
//                self.deviceID = responseData.deviceID
//                self.discountCodes = responseData.discountCodes
//                self.email = responseData.email
//                self.estimatedTaxes = responseData.estimatedTaxes
//                self.financialStatus = responseData.financialStatus
//                self.fulfillmentStatus = responseData.fulfillmentStatus
//                self.gateway = responseData.gateway
//                self.landingSite = responseData.landingSite
//                self.landingSiteRef = responseData.landingSiteRef
//                self.locationID = responseData.locationID
//                self.name = responseData.name
//                self.note = responseData.note
//                self.noteAttributes = responseData.noteAttributes
//                self.number = responseData.number
//                self.orderNumber = responseData.orderNumber
//                self.orderStatusURL = responseData.orderStatusURL
//                self.originalTotalDutiesSet = responseData.originalTotalDutiesSet
//                self.paymentGatewayNames = responseData.paymentGatewayNames
//                self.phone = responseData.phone
//                self.presentmentCurrency = responseData.presentmentCurrency
//                self.processedAt = responseData.processedAt
//                self.processingMethod = responseData.processingMethod
//                self.reference = responseData.reference
//                self.referringSite = responseData.referringSite
//                self.sourceIdentifier = responseData.sourceIdentifier
//                self.sourceName = responseData.sourceName
//                self.sourceURL = responseData.sourceURL
//                self.subtotalPrice = responseData.subtotalPrice
//                self.subtotalPriceSet = responseData.subtotalPriceSet
//                self.tags = responseData.tags
//                self.taxLines = responseData.taxLines
//                self.taxesIncluded = responseData.taxesIncluded
//                self.test = responseData.test
//                self.token = responseData.token
//                self.totalDiscounts = responseData.totalDiscounts
//                self.totalDiscountsSet = responseData.totalDiscountsSet
//                self.totalLineItemsPrice = responseData.totalLineItemsPrice
//                self.totalLineItemsPriceSet = responseData.totalLineItemsPriceSet
//                self.totalOutstanding = responseData.totalOutstanding
//                self.totalPrice = responseData.totalPrice
//                self.totalPriceSet = responseData.totalPriceSet
//                self.totalPriceUsd = responseData.totalPriceUsd
//                self.totalShippingPriceSet = responseData.totalShippingPriceSet
//                self.totalTax = responseData.totalTax
//                self.totalTaxSet = responseData.totalTaxSet
//                self.totalTipReceived = responseData.totalTipReceived
//                self.totalWeight = responseData.totalWeight
//                self.updatedAt = responseData.updatedAt
//                self.userID = responseData.userID
//                self.customer = responseData.customer
//                self.discountApplications = responseData.discountApplications
//                self.fulfillments = responseData.fulfillments
//                self.lineItems = responseData.lineItems
//                self.paymentTerms = responseData.paymentTerms
//                self.refunds = responseData.refunds
//                self.shippingLines = responseData.shippingLines
//            }
//        }
//    }
//}
//
//
//
//// MARK: - CustomerClass
//struct CustomerClass: Codable {
//    let id: Int
//    let email: String
//    let acceptsMarketing: Bool
//    let createdAt, updatedAt: Date
//    let firstName, lastName: String
//    let ordersCount: Int
//    let state, totalSpent: String
//    let lastOrderID: Int
//    let note: String?
//    let verifiedEmail: Bool
//    let multipassIdentifier: String?
//    let taxExempt: Bool
//    let phone: String?
//    let tags, lastOrderName: String
//    let currency: String
//    let acceptsMarketingUpdatedAt: Date
//    let marketingOptInLevel: String?
//    let taxExemptions: [String]
//    let emailMarketingConsent: EmailMarketingConsent
//    let smsMarketingConsent: String?
//    let adminGraphqlAPIID: String
//    let defaultAddress: DefaultAddress
//
//    enum CodingKeys: String, CodingKey {
//        case id, email
//        case acceptsMarketing = "accepts_marketing"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case ordersCount = "orders_count"
//        case state
//        case totalSpent = "total_spent"
//        case lastOrderID = "last_order_id"
//        case note
//        case verifiedEmail = "verified_email"
//        case multipassIdentifier = "multipass_identifier"
//        case taxExempt = "tax_exempt"
//        case phone, tags
//        case lastOrderName = "last_order_name"
//        case currency
//        case acceptsMarketingUpdatedAt = "accepts_marketing_updated_at"
//        case marketingOptInLevel = "marketing_opt_in_level"
//        case taxExemptions = "tax_exemptions"
//        case emailMarketingConsent = "email_marketing_consent"
//        case smsMarketingConsent = "sms_marketing_consent"
//        case adminGraphqlAPIID = "admin_graphql_api_id"
//        case defaultAddress = "default_address"
//    }
//}
//
//// MARK: - DefaultAddress
//struct DefaultAddress: Codable {
//    let id, customerID: Int
//    let firstName, lastName: String
//    let company: String?
//    let address1: String
//    let address2: String?
//    let city: String
//    let province: String?
//    let country: String
//    let zip, phone: String?
//    let name: String
//    let provinceCode: String?
//    let countryCode, countryName: String
//    let defaultAddressDefault: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case customerID = "customer_id"
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case company, address1, address2, city, province, country, zip, phone, name
//        case provinceCode = "province_code"
//        case countryCode = "country_code"
//        case countryName = "country_name"
//        case defaultAddressDefault = "default"
//    }
//}
//
//// MARK: - EmailMarketingConsent
//struct EmailMarketingConsent: Codable {
//    let state, optInLevel: String
//    let consentUpdatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case state
//        case optInLevel = "opt_in_level"
//        case consentUpdatedAt = "consent_updated_at"
//    }
//}
//
//// MARK: - LineItem
//struct LineItem: Codable {
//    let id: Int
//    let adminGraphqlAPIID: String
//    let fulfillableQuantity: Int
//    let fulfillmentService: String
//    let fulfillmentStatus: String?
//    let giftCard: Bool
//    let grams: Int
//    let name, price: String
//    let priceSet: String
//    let productExists: Bool
//    let productID: String?
//    let properties: [String]
//    let quantity: Int
//    let requiresShipping: Bool
//    let sku: String?
//    let taxable: Bool
//    let title, totalDiscount: String
//    let totalDiscountSet: String
//    let variantID, variantInventoryManagement, variantTitle, vendor: String?
//    let taxLines, duties, discountAllocations: [String]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case adminGraphqlAPIID = "admin_graphql_api_id"
//        case fulfillableQuantity = "fulfillable_quantity"
//        case fulfillmentService = "fulfillment_service"
//        case fulfillmentStatus = "fulfillment_status"
//        case giftCard = "gift_card"
//        case grams, name, price
//        case priceSet = "price_set"
//        case productExists = "product_exists"
//        case productID = "product_id"
//        case properties, quantity
//        case requiresShipping = "requires_shipping"
//        case sku, taxable, title
//        case totalDiscount = "total_discount"
//        case totalDiscountSet = "total_discount_set"
//        case variantID = "variant_id"
//        case variantInventoryManagement = "variant_inventory_management"
//        case variantTitle = "variant_title"
//        case vendor
//        case taxLines = "tax_lines"
//        case duties
//        case discountAllocations = "discount_allocations"
//    }
//}
