# FPGA_Multi_Module_System 

**Verilog 기반 멀티 모듈 FPGA 시스템**  
Timer, Stopwatch, HC-SR04 초음파 센서, DHT11 온습도 센서, UART(FIFO 포함) 제어 로직을 직접 설계 및 검증하였습니다.  
출력은 FND와 ComPort Master를 통해 시각화 및 데이터 전송이 가능합니다.

<br>

## 프로젝트 개요

| 항목       | 내용 |
|------------|------|
| 수행 기간  | 2025.05.27 ~ 2025.06.17 |
| 개발 환경  | Vivado, VSCode |
| 플랫폼     | Basys3 FPGA 보드 |
| 언어       | Verilog HDL |
| 통신       | UART 통신 (FIFO 포함) |
| 센서       | HC-SR04 (초음파 거리 센서), DHT11 (온습도 센서) |

<br>

## 주요 기능

### ⏱ 스톱워치 및 디지털 시계
- 버튼으로 시간 측정 / 정지 / 초기화
- 분:초 / 시:분 모드 전환 가능
- 정시 알람 신호 출력

### 7-Segment 디스플레이 제어
- 시계, 스톱워치, 센서 데이터 동적 출력
- 클럭 분주 및 다중 자리 선택 방식 구현
- 스위치(sw[5], sw[6]) 조합으로 출력 모드 선택 (시계 / 거리 / 온습도)

### 초음파 거리 측정 (HC-SR04)
- 거리값을 FND 및 UART로 출력
- `"Distance = xxxxcm"` 형식의 문자열 전송
- UART 전송 버퍼(FIFO) 및 FSM 기반 송신 로직

### 온습도 측정 (DHT11)
- 온도·습도 값을 FND 및 UART로 출력
- `"Temp = XXC / Humi = XX%"` 형식 문자열 전송
- 전용 FSM으로 데이터 동기화 및 유효성 검증

### UART 통신 기반 명령 처리
- `"RESET"`, `"CLEAR"`, `"SR"`, `"DHT"`, `"UP"`, `"DOWN"` 명령 수신 및 동작
- UART 수신 FIFO와 FSM 기반 명령 파서

<br>

## System Diagram
<img width="1337" height="670" alt="image" src="https://github.com/user-attachments/assets/309569b0-6062-4562-a033-0eadcfb4b7a5" />

<br>

## SR-04 Diagram
<img width="1251" height="681" alt="image" src="https://github.com/user-attachments/assets/e762e0a7-b240-48a2-9f19-796ecf9c430f" />



