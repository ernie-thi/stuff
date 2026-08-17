from dotenv import load_dotenv
from pathlib import Path
import argparse
import base64
import mimetypes

from langchain.tools import tool
from langchain.agents import create_agent
from langgraph.checkpoint.memory import InMemorySaver
from langchain.messages import HumanMessage
from typing import Dict, Any
from exa_py import Exa


system_prompt = """
You are a personal chef. The user will either give you a list of ingredients they have available. Or an image of their fridge, which shows you what ingredients are available.

Do not assume the user has any ingredients other than the list, e.g. if the user does not mention any vegetables or spices, they are not available.
Using the web search tool, search the web for recipes that can be made with the ingredients they have.

Return recipe suggestions and eventually the recipe instructions to the user, if requested.

In case of an image, first answer with the recognized ingredients like: 

The following ingredients are in the image:
-> cheese, tomato, pepper, salt, salmon
"""


def encode_b64(image_path: Path) -> str:
    try:
        if not image_path.exists():
            raise FileNotFoundError(f"Image not found at: {image_path}")
        return base64.b64encode(image_path.read_bytes()).decode("utf-8")
    except TypeError as e:
        print(f"Error in encoding: {e}")
        raise e
        


def env_setup():
    api_path= Path('/home/ernie/.env')
    load_dotenv(dotenv_path=api_path)

@tool
def web_search(query: str) -> Dict[str, Any]:
    """Search the web for information"""
    exa = Exa()
    return exa.search(query, contents={"highlights": True})


def main():
    # setup parser
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", "--prompt",
                        type=str, help="Insert specific prompt")
    parser.add_argument("-i", "--image", type=Path, help="Path to an image")
    args = parser.parse_args()


    # setup environment
    env_setup()

    # setup agent
    agent = create_agent(
            model="gpt-5-nano",
            tools=[web_search],
            system_prompt=system_prompt,
            checkpointer=InMemorySaver()
            )
    
    config = {"configurable": {"thread_id": "1"}} 

    if args.image:
        mime_type, _ = mimetypes.guess_type(args.image) # e.g. image/jpeg image/png
        img_b64 = encode_b64(args.image)
        question = HumanMessage(content=[
            {"type": "text", "text": "What can i cook from the ingredients shown in this image?"},
            {"type": "image", "base64": img_b64, "mime_type": mime_type},
            ]
            )
    elif args.prompt is None or not args.prompt.strip():
        question = HumanMessage(content=[
            {"type": "text", "text": "What can i cook from chicken, rice and curry ?"},
            ]
            )

    else:
        question = HumanMessage(content=[
            {"type": "text", "text": args.prompt},
            ]
            )

    response = agent.invoke(
            {"messages": [question]},
            config
            )

    print(response['messages'][-1].content)




if __name__ == "__main__":
    main()
