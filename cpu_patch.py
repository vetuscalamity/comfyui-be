with open("comfy/model_management.py", "r") as file:
    content = file.read()

# GPU kontrollerini devre dışı bırak
content = content.replace("torch.device(torch.cuda.current_device())", "'cpu'")
content = content.replace("if torch.cuda.is_available()", "if False")
content = content.replace("if not torch.cuda.is_available()", "if True")

with open("comfy/model_management.py", "w") as file:
    file.write(content)
