/*�ϳ��� �Խñۿ� ���� ������ �����ϴ� �����ͺ��̽��� ������ �� �ִ� Ŭ����
bbs��� ��Ű���� bbs��� �ϳ��� �ڹٺ�� �������.
�ڹٺ���� �ϳ��� �Խñ� ������ ���� �� �ִ� �ν��Ͻ��� ����� ���� Ʋ�̴�
�����ͺ��̽� ���̺�� ���� ����ϸ� �������� �Խñ��� �ϳ��� �������� �� �ִ� �ϳ��� �ڹ����α׷����� ��*/


package bbs;

public class Bbs {

	private int bbsID; /*�Խñ��� ��ȣ*/
	private String bbsTitle; /*�Խù��� ����*/
	private String userID; /*�ۼ���*/
	private String bbsDate; /*�ۼ��� ��¥*/
	private String bbsContent; /*�Խñ��� ��*/
	private int bbsAvailable; /*���� ���� �����Ǿ����� �ȵǾ��ִ��� �Ǵ�. 1- ���� �ȵ� 0 - ���� �� <�� ��������>*/
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

/*�̷��� �����ν�, �����ϰ� bbs��� �̸����� �ڹٺ��� Ŭ������ �������.
�츮�� jsp �Խ��� ������Ʈ���� ���� �Խ��� ���̹� ���̽��� ������.*/
