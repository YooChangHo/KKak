/*하나의 게시글에 대한 정보를 관리하는 데이터베이스에 접근할 수 있는 클래스
bbs라는 패키지에 bbs라는 하나의 자바빈즈를 만들어줌.
자바빈즈는 하나의 게시글 정보를 닮을 수 있는 인스턴스를 만들기 위한 틀이다
데이터베이스 테이블과 아주 흡사하며 전반적인 게시글을 하나를 관리해줄 수 있는 하나의 자바프로그램같은 것*/


package bbs;

public class Bbs {

	private int bbsID; /*게시글의 번호*/
	private String bbsTitle; /*게시물의 제목*/
	private String userID; /*작성자*/
	private String bbsDate; /*작성된 날짜*/
	private String bbsContent; /*게시글의 글*/
	private int bbsAvailable; /*현재 글이 삭제되었는지 안되어있는지 판단. 1- 삭제 안됨 0 - 삭제 됨 <글 삭제목적>*/
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public String getBbsTitle() {
		return bbsTitle;
	}
	public void setBbsTitle(String bbsTitle) {
		this.bbsTitle = bbsTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getBbsDate() {
		return bbsDate;
	}
	public void setBbsDate(String bbsDate) {
		this.bbsDate = bbsDate;
	}
	public String getBbsContent() {
		return bbsContent;
	}
	public void setBbsContent(String bbsContent) {
		this.bbsContent = bbsContent;
	}
	public int getBbsAvailable() {
		return bbsAvailable;
	}
	public void setBbsAvailable(int bbsAvailable) {
		this.bbsAvailable = bbsAvailable;
	}
	

}

/*이렇게 함으로써, 간단하게 bbs라는 이름으로 자바빈즈 클래스가 만들어짐.
우리의 jsp 게시판 웹사이트에서 사용될 게시판 데이버 베이스를 구축함.*/
