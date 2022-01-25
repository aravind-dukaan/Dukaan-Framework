//
//  Closures.swift
//  Dukaan
//
//  Created by Raja Earla on 10/03/21.
//

import Foundation
//import Model

typealias OnProductSuggestionCompletion = ((_ reload: Bool) -> Void)

typealias CloseAction = (() -> Void)

typealias ActionBlock = (() -> Void)

typealias InsertionBlock = ((_ insertedIndexPath: IndexPath?, _ errorIndexPath: IndexPath?) -> Void)

typealias SuccessOrFailureBlock = ((_ success: Bool) -> Void)

typealias DisableClosure = ((_ disable: Bool) -> Void)

typealias EnableClosure = ((_ enable: Bool) -> Void)

typealias ReloadSectionBlock = ((_ section: Int) -> Void)

//typealias ProductImageSuggestionBlock = ((_ results: [ProductSuggestImage]?) -> Void)

public typealias AlertCompetionBlock = (() -> Void)

typealias ReloadCellBlock = ((_ reloadIndexPath: IndexPath?) -> Void)

typealias OnDeleteChargeCellBlock = ((_ deleteIndexPath: IndexPath?) -> Void)

typealias OnStoreCatlogueExportEventBlock = ((_ result: Any) -> Void)

typealias OnCouponExportEventBlock = ((_ result: Any) -> Void)

typealias OnOrderReportExportEventBlock = ((_ result: Any) -> Void)

typealias OnMyCustomerListExportEventBlock = ((_ result: Any) -> Void)

typealias OnProductHawkEyeImageSearchEventBlock = ((_ result: Any) -> Void)

typealias OnPaymentStatusEventBlock = ((_ result: Any) -> Void)

typealias DownloadCompletionBlock = ((_ fileLocation: URL, _ data: Data?) -> Void)

typealias ProgressBlock = ((_ progress: Int) -> Void)

typealias OnPaymentSuccessResponse = ((_ options: [String: Any]?, _ payment_id: String, _ paymentResponse: [AnyHashable: Any]?) -> Void)
typealias OnPaymentErrorResponse = ((_ code: Int32, _ errStr: String) -> Void)
/*
typealias OnRazorpayOrderBlock = ((_ storeRazorPayOrder: PaymentRazorPayOrder?) -> Void)

typealias StoreListResponseBlock = ((_ stores: [Store]) -> Void)
typealias ResellerSharedProductBlock = ((_ success: Bool) -> Void)
typealias ReloadAccountStatsOfResellerBlock = ((_ success: Bool) -> Void)
typealias OnKeyboardApppearanceChangeBlock = ((_ keyboardHeight: CGFloat, _ isActive: Bool) -> Void)
typealias StoreDeliveryInfoErrorBlock = ((_ error: StoreInfoFieldError?) -> Void)
typealias StoreWareHouseBlock = ((_ storeWarehouse: StoreWarehouse?) -> Void)
typealias OrderShippingDetailsBlock = ((_ shippingDetails: ShippingDetails?) -> Void)
typealias OnChoosePlanPriceBlock = ((_ selectedPlanPrice: StorePlanPriceData) -> Void)
typealias OnStoreInfoFieldsErrorBlock = ((_ fields: [StoreInfoFieldError]) -> Void)
typealias CancelShipmentBlock = ((_ cancelModel: CancelShipmentModel?) -> Void)
typealias BulkShipmentLogisticBlock = ((_ result: Any) -> Void)
typealias OnDeleteDropDownOption = ((_ newPlaceholder: String) -> Void)
typealias OnPeriodSwitchChangeBlock = ((_ period: String) -> Void)
typealias UpdateColumnIndexBlock = ((_ columnIndex: Int) -> Void)
typealias OnPluginCompletion = ((_ plugin: PluginModel?) -> Void)
*/
