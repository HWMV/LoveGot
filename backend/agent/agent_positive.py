# agent 구성을 위한 스크립트
import os
from openai import OpenAI
from agent.config.agentconfig import AgentConfig
# client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
from typing import Tuple
import json
from agent.config.prompts import SYSTEM_PROMPT, REQUEST_PROMPT_TEMPLATE

class GottmanAgent:
    def __init__(self):
        # 여기서는 OS 환경변수(OPENAI_API_KEY)를 통해 가져옴
        self.model = AgentConfig.MODEL_NAME

    def generate_positive_statements(self, user_input: str) -> Tuple[str, str, str]:
        """
        user_input을 받아 GPT를 통해 긍정적 화법 3문장을 생성 후 (Answer1, Answer2, Answer3)를 리턴
        """
        client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

        messages = [
            {
                "role": "system",
                "content": SYSTEM_PROMPT.strip()
            },
            {
                "role": "user",
                "content": REQUEST_PROMPT_TEMPLATE.format(user_input=user_input)
            }
        ]

        try:
            # client = openai.OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
            response = client.chat.completions.create(model=self.model,
            messages=messages,
            temperature=0.7,
            max_tokens=300)
            answer_text = response.choices[0].message.content.strip()

            # JSON 응답 파싱
            answers = json.loads(answer_text)

            return (
                answers["Answer1"],
                answers["Answer2"],
                answers["Answer3"]
            )

        except json.JSONDecodeError as e:
            print("JSON 파싱 에러:", e)
            return ("JSON 파싱 오류가 발생했습니다.", "응답 형식이 올바르지 않습니다.", str(e))
        except Exception as e:
            # 실제 서비스에서는 로깅이 필요
            print("GPT API Error:", e)
            # 기본 문장 3개 리턴 or 예외 재전달
            return ("에러가 발생했습니다.", "GPT API 오류", str(e))
