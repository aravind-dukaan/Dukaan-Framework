//
//  Constants.swift
//  Dukaan
//
//  Created by Raja Earla on 11/03/21.
//

// swiftlint:disable all
import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let popupVCBgAlpha = CGFloat(0.6)
let maxProductSuggestionCount = Int(8)
let restaurantProductChatCount = Int(70)
let nonRestaurantProductChatCount = Int(4000)
//let buildConfig = Bundle.main.configType
let unlimitedMaxLimit = Double(10000000)
let dukaanPremiumTitle = "Dukaan Premium"

let defaultCountryID = Int(77) // India
let defaultCurrencyCode = "INR"
let defaultCurrencyLocale = "en_IN"
let defaultCountryCode = "91"
let planCurrencySymbol = "$" // by default for buying a plan is "$" only

let defaultStoreImageUrl = "https://api.mydukaan.io/static/store-def.jpg"
let defaultCategoryImageUrl = "https://api.mydukaan.io/static/images/category-def.jpg"
let appstoreLink = "itms-apps://https://apps.apple.com/app/id1560859298"
let appstoreHttpsLink = "https://apps.apple.com/app/id1560859298"
let facebookGroupLink = "https://www.facebook.com/groups/dukaanapp"
let internationalFbGroupLink = "https://www.facebook.com/groups/316594216644571/"

let dukaanTermsAndConditionsUrl = "https://mydukaan.io/terms"

public struct Constants {
    
    struct Api {
        static let createdBefore = "created_at_before"
        static let createdAfter = "created_at_after"
        static let selection = "selection"
        static let search = "search"
        static let createdAtUTC = "created_at_utc"
        static let createdAt = "created_at"
    }
    
    struct Deeplink {
        static let applink = "mydukaan.app.link"
        static let pagelink = "mydukaan.page.link"
        static let mydukaanapplink = "mydukaanapplink"
        static let myapplink = "myapp"
        static let domain = "com.mydukaan"
        static let source = "source"
        static let home   = "home"
        static let products = "products"
        static let key = "deep_link"
        static let orderId = "order_id"
    }
    
    struct NotificationInfo {
        static let pdfLink = "pdf_link"
        static let type = "type"
        static let orderType = "order_type"
        static let reportDownloaded = "ORDER_REPORT_DOWNLOADED"
    }
    struct Expiry {
        static let overView = "Store Overview"
        static let overView90Days = "Last 90 days overview"
        static let renewYourDukaan = "Renew your Dukaan Premium subscription and generate more sales!"
        static let upgradeYourDukaan = "Upgrade your Dukaan Premium subscription and generate more sales!"
        static let whatToExpect = "What to expect when continuing with Free plan"
        static let planDuration = "Plan duration:"
        static let trialDuration = "Trial duration:"
    }
    struct OrderDetail {
        static let requestPayment = "Request online payment"
        static let request = "Request"
        static let success = "Request successfully sent to your customer."
        static let moreAttempt = "You can request online payments 3 times only."
        static let orderIdNotValid = "Order Id is not valid"
    }
    struct ProdctReviews {
        static let noReviews = "You don’t have any reviews."
    }
    struct OrdersTipsVideo {
        static let tipsVideoLinkID = "p-QMC7ynLyE"
    }
}

enum UrlSchemes : String {
    case TrueCaller = "truesdk://",
    Facebook = "fb://",
    WhatsApp = "whatsapp://",
    FBMessenger = "fb-messenger://"
  }

public enum Deeplinks: String, CaseIterable {
    case home = "home"
    case products = "products"
    case account = "account"
    case orderDetails = "order_details"
    case shareApp = "share_app"
    case getOwnApp = "get_own_app"
    case addProduct = "add_product"
    case marketingDesigns = "marketing_designs"
    case onlinePayments = "online_payments"
    case coupons = "coupons"
    case myCustomers = "my_customers"
    case storeQRCode = "store_qr_code"
    case extraCharges = "extra_charges"
    case orderForm = "order_form"
    case dukaanPremium = "dukaan_premium"
    case dukaanForPc = "dukaan_for_pc"
    case restaurantDining = "restaurant_dining"
    case editBusiness = "edit_business"
    case dukaanVipFb = "dukaan_vip_fb"
    case ordersList = "orders_list"
    case dukaanMarketing = "dukaan_marketing"
    case dukaanPlugins = "dukaan_plugins"
    case dukaanThemes = "dukaan_themes"
    case dukaanCredits = "dukaan_credits"
    case dukaanDelivery = "dukaan_delivery"
    case dukaanPlus = "dukaan_plus"
}

struct ScreenSize {
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType {
    static let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1024.0
    static let IS_IPAD_PRO = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   == 1366.0
    static let IS_IPHONE_XSMAX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 2688
    static let IS_IPHONE_XR = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1792
    
    static let isSmallerDevice = DeviceType.IS_IPHONE_4_OR_LESS || DeviceType.IS_IPHONE_5
}

enum OnboardingDataUpdateType: String {
    case addedProduct = "added_product",
         added3Products = "added_3_products",
         sharedStoreLink = "shared_store_link",
         addedStoreAddress = "added_store_address",
         addedPaymentMethod = "added_payment_method",
         resellerNonSkippableVideoWatched = "reseller_non_skippable_video_watched"
}

extension OnboardingDataUpdateType {
    init?(rawValue: String) {
        switch rawValue {
        case "added_product": self = .addedProduct
        case "added_3_products": self = .added3Products
        case "shared_store_link": self = .sharedStoreLink
        case "added_store_address": self = .addedStoreAddress
        case "added_payment_method": self = .addedPaymentMethod
        default: return nil
        }
    }
}

//public func isSeller() -> Bool {
//    return AppStateManager.shared.isSeller
//}

struct WebLinks {
    static let myCustomersHelpLink = "https://help.mydukaan.io/en/articles/5151332-how-to-use-my-customers"
    static let storeQRHelpLink = "https://help.mydukaan.io/en/articles/5000515-how-to-use-store-qr-code"
    static let onlinePaymentsLink = "https://help.mydukaan.io/en/articles/4696972-how-to-enable-online-payments"
    static let myCommissionsLink = "https://help.mydukaan.io/en/articles/5508508-how-can-i-get-my-dukaan-plus-earnings"
    static let dukaanDeliveryHelpLink = "https://help.mydukaan.io/en/articles/5516681-how-to-use-dukaan-delivery"
    static let marketingCampaignsLink = "https://help.mydukaan.io/en/articles/5499424-how-to-use-marketing-campaigns"
    static let addCreditsLink = "https://help.mydukaan.io/en/articles/5496150-how-to-use-dukaan-credits"
    static let extraChargesLink = "https://help.mydukaan.io/en/articles/5006716-how-to-use-extra-charges-for-hotel-restaurants"
    static let promoDesignsLink = "https://help.mydukaan.io/en/articles/4696964-how-to-use-promotional-designs"
    static let couponsLink = "https://help.mydukaan.io/en/articles/5000508-how-to-use-discount-coupons"
    static let stripeHelpLink = "https://help.mydukaan.io/en/articles/5207597-how-to-integrate-stripe-with-dukaan"
}

extension Notification {
    static var reloadOrdersNotification = Notification(name: .reloadOrdersNotification)
    static var reloadTableListNotification = Notification(name: .reloadTableListNotification)
    static var storeUpdateNotification = Notification(name: .storeUpdateNotification)
}

extension Notification.Name {
    static var reloadOrdersNotification = Notification.Name("reloadOrdersNotification")
    static var reloadTableListNotification = Notification.Name("reloadTableListNotification")
    static var kOrderBadgeNotification = Notification.Name("kOrderBadge")
    static var storeUpdateNotification = Notification.Name("storeUpdateNotification")
    static var showUpgradeNotification = Notification.Name("showUpgradeNotification")
    
}
