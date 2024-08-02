<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
button {
  width:50%;
  appearance: none;
  border: none;
  outline: none;
  display: block;
  color: #fff;
  margin: 0;
  display: block;
  min-width: 120px;
  padding: 12px 20px;
  font: 600 16px/24px 'Inter';
  border-radius: 10px;
  background: #15181C;
  box-shadow: 0px 8px 20px -8px rgba(26, 33, 43, 0.50), 0px 4px 12px 0px rgba(26, 33, 43, 0.05), 0px 1px 3px 0px rgba(26, 33, 43, 0.25), 0px 1.5px 0.5px 0px #454D57 inset, 0px -3px 1px 0px rgba(0, 0, 0, 0.50) inset;
  transform: ranslateZ(0);
  transition: transform .2s;

  &:hover {
    transform: scaleX(1.03) scaleY(1.06) translateZ(0);
  }

  &:active {
    transform: scaleX(.98) scaleY(.96) translateZ(0);
  }
}
</style>
</head>
<body>
<button onclick="window.location.href='/userLogin';">로그인/회원가입</button><br/>
<button onclick="window.location.href='/shop/payment';">비회원 주문</button>
<script type="text/javascript" src="/resources/js/jquery-3.5.1.min.js"></script>
<script>

</script>
</body>
</html>