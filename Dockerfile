# 베이스 이미지 선택 (Python 3.10 사용 예시)
FROM python:3.10-slim

# 작업 디렉토리 생성 및 설정
WORKDIR /app

# 현재 디렉토리의 파일을 컨테이너로 복사
COPY . /app

# 시스템 패키지 설치 (필요시)
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Python 의존성 설치 (requirements.txt가 있는 경우)
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt

# 포트 노출 (gunicorn에서 사용)
EXPOSE 8000

# 환경 변수 설정 (옵션)
ENV PYTHONUNBUFFERED=1

# 실행 명령 (docker-compose에서의 `command:`에 해당)
CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:8000"]
