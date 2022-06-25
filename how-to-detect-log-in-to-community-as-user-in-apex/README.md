# Introduction

`Log in to Community as User` is a feature provided by Salesforce, which allows users with “Manage External Users” permission login to the community as a selected account’s contact (user).  
It can be a potential cause of problems because in some cases we want to hide some sensitive data from internal users. Below I described a logic that helps you to detect that an internal user is logged to the community on behalf of community user.

If we want to see `Log in to Community as User` button, we must fulfill a few points:
– Ensure that Communities are enabled in your org.
– Ensure that your profile has Manage External Users’ permission.
– Ensure that the contact is associated with an account and community user is created.

After clicking this button you should be able to log in to a community in contact (user) context, has whole access to the user’s system and be able do actions on behalf.

## Apex
We can use the standard Apex method `Auth.SessionManagement.getCurrentSession()`, which provide some session information:

```java
{
  SessionId=0Ak###############, 
  UserType=Standard, 
  ParentId=0Ak###############, 
  NumSecondsValid=7200, 
  LoginType=SAML Idp Initiated SSO, 
  LoginDomain=null,
  LoginHistoryId=0Ya###############,
  Username=user@domain.com, 
  CreatedDate=Wed Jul 30 19:09:29 GMT 2014, 
  SessionType=Visualforce, 
  LastModifiedDate=Wed Jul 30 19:09:16 GMT 2014, 
  LogoutUrl=https://google.com, 
  SessionSecurityLevel=STANDARD,
  UsersId=005###############, 
  SourceIp=1.1.1.1
}
```

We can easily check that someone else is logged in to a community as a current user checking **UserType**, **SourceIp** and **LoginType**.

```java
    public Boolean isLoggedOnBehalf() {
        Map<String, String> session = Auth.SessionManagement.getCurrentSession();
        return session.get('UserType') == 'Standard' &&
               session.get('SourceIp') == '::' && 
               session.get('LoginType') == null;
    }
```

## Resources 
- [Unable to see 'Manage External Users' button in Contact layout](https://help.salesforce.com/articleView?id=000338375&type=1&mode=1)
- [SessionManagement Class](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_class_Auth_SessionManagement.htm)