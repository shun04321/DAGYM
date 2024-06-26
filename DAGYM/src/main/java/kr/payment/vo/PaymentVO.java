package kr.payment.vo;

import java.sql.Date;

public class PaymentVO {
	private int pay_num;
	private int mem_num;
	private int pay_fee;
	private int pay_enroll;
	private Date pay_reg_date;
	private int pay_status;
	
	private String mem_name;
	private Date pay_exp;
	private int points;

	public int getPay_num() {
		return pay_num;
	}

	public void setPay_num(int pay_num) {
		this.pay_num = pay_num;
	}

	public int getMem_num() {
		return mem_num;
	}

	public void setMem_num(int mem_num) {
		this.mem_num = mem_num;
	}

	public int getPay_fee() {
		return pay_fee;
	}

	public void setPay_fee(int pay_fee) {
		this.pay_fee = pay_fee;
	}

	public int getPay_enroll() {
		return pay_enroll;
	}

	public void setPay_enroll(int pay_enroll) {
		this.pay_enroll = pay_enroll;
	}

	public Date getPay_reg_date() {
		return pay_reg_date;
	}

	public void setPay_reg_date(Date pay_reg_date) {
		this.pay_reg_date = pay_reg_date;
	}

	public int getPay_status() {
		return pay_status;
	}

	public void setPay_status(int pay_status) {
		this.pay_status = pay_status;
	}

	public String getMem_name() {
		return mem_name;
	}

	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}

	public Date getPay_exp() {
		return pay_exp;
	}

	public void setPay_exp(Date pay_exp) {
		this.pay_exp = pay_exp;
	}

	public int getPoints() {
		return points;
	}

	public void setPoints(int points) {
		this.points = points;
	}
}
