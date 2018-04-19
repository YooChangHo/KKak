package user;

public class User {

	private String userID; /*mySQL 에서 만든 DATABASE TABLE 과 동일한 이름으로 만드는게 가장 깔끔*/
	private String userPassword;
	private String userName;
	private String userGender;
	private String userEmail;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserGender() {
		return userGender;
	}
	public void setUserGender(String userGender) {
		this.userGender = userGender;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	/*한명의 회원 데이터를 다룰 수 있는 데이터베이스와 자바빈즈가 완성됨.  
	자바빈즈 - 하나의 데이터를 관리하고 처리할 수 있는 기법을 JSP에서 구현하는 것을 자바빈즈라고 함.
	-> 자바빈즈로 유저클래스를 만듬. */
	
	
}
