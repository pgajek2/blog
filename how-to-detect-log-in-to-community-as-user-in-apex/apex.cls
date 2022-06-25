public class CurrentUserUtils {

    public static Boolean isLoggedOnBehalf() {
        Map<String, String> currentSession = Auth.SessionManagement.getCurrentSession();
        return currentSession.get('UserType') == 'Standard' &&
               currentSession.get('SourceIp') == '::' &&
               currentSession.get('LoginType') == null;
    }
}
