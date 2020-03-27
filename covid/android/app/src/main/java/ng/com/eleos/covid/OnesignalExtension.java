package ng.com.eleos.covid;
import com.onesignal.OSNotificationPayload;
import com.onesignal.OSNotificationReceivedResult;
import com.onesignal.NotificationExtenderService;


public class OnesignalExtension extends NotificationExtenderService  {
    @Override
    protected boolean onNotificationProcessing(OSNotificationReceivedResult receivedResult) {
        if (receivedResult != null) {




        }

        // Returning true tells the OneSignal SDK you have processed the notification and not to display it's own.
        return false;
    }

}

//        extends NotificationExtenderService {
//    @Override
//    protected boolean onNotificationProcessing(OSNotificationReceivedResult receivedResult) {
//        // Read properties from result.
//
//        // Return true to stop the notification from displaying.
//        return false;
//    }
//}