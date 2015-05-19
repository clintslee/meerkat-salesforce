public with sharing class MeerkatRestException extends Exception 
{
	private Integer status;
	private Integer errorCode;
	private String message;

	public MeerkatRestException(String message, Integer errorCode) 
	{
		this.message = message;
		this.errorCode = errorCode;
	}
}