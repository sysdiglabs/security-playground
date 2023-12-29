# tester-client
import requests
import argparse

def send_request(url):
    try:
        response = requests.get(url)
        print(f"Response from {url}:")
        print(response.text)
    except requests.exceptions.RequestException as e:
        print(f"Error making request to {url}: {e}")

def main():
    parser = argparse.ArgumentParser(description="Simple HTTP Client")
    parser.add_argument('url', type=str, help='URL to send the HTTP request to')
    
    args = parser.parse_args()
    send_request(args.url)

if __name__ == '__main__':
    main()
