package kr.payment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.member.vo.MemberVO;
import kr.payment.dao.PaymentDAO;
import kr.payment.vo.PaymentVO;
import kr.qaboard.vo.QABoardVO;
import kr.util.DBUtil;

public class PaymentDAO {
	//싱글턴 패턴
	private static PaymentDAO instance = new PaymentDAO();

	public static PaymentDAO getInstance() {
		return instance;
	}
	private PaymentDAO () {}
	
	//회원권상담신청
	public void membershipCounseling(QABoardVO qaboard)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO qaboard (qab_num,mem_num,qab_type,qab_title,qab_content,qab_ip,qab_remove,qab_ref) VALUES(qaboard_seq.nextval,?,4,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, qaboard.getMem_num());
			pstmt.setString(2, qaboard.getQab_title());
			pstmt.setString(3, qaboard.getQab_content());
			pstmt.setString(4, qaboard.getQab_ip());
			pstmt.setInt(5, qaboard.getQab_remove());
			pstmt.setInt(6, qaboard.getQab_ref());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//회원별 회원권 결제내역 총 개수(회원상세)
	public int getPayMemCount(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM payment WHERE mem_num=? ";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	
	//회원상세(회원권 결제내역)
	public List<PaymentVO>getPayMemList(int mem_num,int start,int end)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PaymentVO>list = null;
		String sql = null;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT mem_num,mem_name,pay_num,pay_fee,pay_enroll,pay_reg_date,pay_status,"
					+ "CASE WHEN pay_enroll = 10 THEN ADD_MONTHS(pay_reg_date,5) "
					+ "WHEN pay_enroll = 20 THEN ADD_MONTHS(pay_reg_date,10) "
					+ "WHEN pay_enroll = 30 THEN ADD_MONTHS(pay_reg_date,15) "
					+ "END pay_exp FROM payment JOIN member_detail "
					+ "USING(mem_num) WHERE mem_num=? ORDER BY pay_num DESC)a) "
					+ "WHERE rnum >= ? AND rnum <= ?";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<PaymentVO>();
			while(rs.next()) {
				PaymentVO payment = new PaymentVO();
				payment.setMem_num(rs.getInt("mem_num"));
				payment.setPay_num(rs.getInt("pay_num"));
				payment.setPay_fee(rs.getInt("pay_fee"));
				payment.setPay_enroll(rs.getInt("pay_enroll"));
				payment.setPay_reg_date(rs.getDate("pay_reg_date"));
				payment.setPay_exp(rs.getDate("pay_exp"));
				payment.setMem_name(rs.getString("mem_name"));
				payment.setPay_status(rs.getInt("pay_status"));
				
				list.add(payment);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//회원 이름
	public String getMemberName(int mem_num) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String mem_name = null;
	    try {
	        conn = DBUtil.getConnection();
	        String sql = "SELECT mem_name FROM member_detail WHERE mem_num=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, mem_num);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            mem_name = rs.getString("mem_name");
	        }
	    } catch (Exception e) {
	        throw new Exception(e);
	    } finally {
	        DBUtil.executeClose(rs, pstmt, conn);
	    }
	    return mem_name;
	}
	
	//보유한 회원권 계산 (남은 회원권)
	public int remainpayment(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int remain = 0;
		try {
			//커넥션 풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT (COALESCE(SUM(p.pay_enroll), 0) - COALESCE((SELECT COUNT(*) FROM history h "
					+ "WHERE h.mem_num = p.mem_num AND h.his_status != 3), 0)) AS result FROM payment p WHERE p.mem_num = ? AND p.pay_status = 0 "
					+ "GROUP BY p.mem_num";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				remain = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return remain;
	}
	
	//회원권 등록(관리자)
			public void insertMembership(PaymentVO payment)throws Exception{
				Connection conn = null;
				PreparedStatement pstmt = null;
				PreparedStatement pstmt2 = null;
				String sql = null;
				
				try {
					//커넥션 풀로부터 커넥션 할당
					conn = DBUtil.getConnection();
		            //오토커밋 해제
					conn.setAutoCommit(false);
					
					//SQL문 작성
					sql = "INSERT INTO payment (pay_num, pay_fee, pay_enroll, mem_num) VALUES (payment_seq.nextval, ?, ?, ?)";
					//PreparedStatement 객체 생성
					pstmt = conn.prepareStatement(sql);
					//?에 데이터 바인딩
					pstmt.setInt(1, payment.getPay_fee());
					pstmt.setInt(2, payment.getPay_enroll());
					pstmt.setInt(3, payment.getMem_num());
					//SQL문 실행
					pstmt.executeUpdate();
					
		            //SQL문 작성 (포인트 +300p)
		            sql = "INSERT INTO point (poi_num, mem_num, poi_type, poi_in, poi_in_date) "
		                + "VALUES (point_seq.nextval, ?, '회원권 등록', ?, sysdate)";
		            pstmt2 = conn.prepareStatement(sql);
		            pstmt2.setInt(1, payment.getMem_num());
		            pstmt2.setInt(2, payment.getPoints());
					pstmt2.executeUpdate();
				
					conn.commit();
					
				}catch(Exception e) {
					conn.rollback();
					throw new Exception(e);
				}finally {
					DBUtil.executeClose(null, pstmt2, null);
					DBUtil.executeClose(null, pstmt, conn);
				}
			}
	
	//회원권 결제취소(관리자)
		public void updateMembership(int pay_num, int mem_num)throws Exception{
			Connection conn = null;
	        PreparedStatement pstmt = null;
	        PreparedStatement pstmt2 = null;
			String sql = null;
			
			try {
				//커넥션 풀로부터 커넥션 할당
				conn = DBUtil.getConnection();
	            //오토커밋 해제
				conn.setAutoCommit(false);
				
	            //1. 포인트 회수 (먼저 실행해야 att_num을 받아올 수 있다)
				sql = "DELETE FROM point WHERE mem_num=? AND poi_type='회원권 등록' "
					+ "AND poi_in_date=(SELECT pay_reg_date FROM payment WHERE pay_num=?)";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, mem_num);
	            pstmt.setInt(2, pay_num);
				pstmt.executeUpdate();
				
				//SQL문 작성
				sql = "UPDATE payment SET pay_status = 1 WHERE pay_num = ?";
				//PreparedStatement 객체 생성
				pstmt2 = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				pstmt2.setInt(1, pay_num);
				//SQL문 실행
				pstmt2.executeUpdate();
				
				conn.commit();
				
			}catch(Exception e) {
				conn.rollback();
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(null, pstmt2, null);
				DBUtil.executeClose(null, pstmt, conn);
			}
		}
		
		//만료한 회원권 업데이트
		public void updateExpMembership() throws Exception {
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    String sql = null;
		    try {
		        // 커넥션 풀로부터 커넥션 할당
		        conn = DBUtil.getConnection();
		        // SQL문 작성
		        sql = "UPDATE payment "
		                + "SET pay_status = 2 "
		                + "WHERE pay_status = 0 "
		                + "AND ( "
		                + "      (pay_enroll = 10 AND ADD_MONTHS(pay_reg_date, 5) < SYSDATE) "
		                + "   OR (pay_enroll = 20 AND ADD_MONTHS(pay_reg_date, 10) < SYSDATE) "
		                + "   OR (pay_enroll = 30 AND ADD_MONTHS(pay_reg_date, 15) < SYSDATE) "
		                + ")";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.executeUpdate();

		    } catch (Exception e) {
		        throw new Exception(e);
		    } finally {
		        DBUtil.executeClose(null, pstmt, conn);
		    }
		}
}