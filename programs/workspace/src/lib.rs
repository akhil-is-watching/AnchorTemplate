use anchor_lang::prelude::*;

declare_id!("44JMUGdj8cevazgeDRH5nx3gxrZkcCLbst8ub8JSe4em");

#[program]
pub mod workspace {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>) -> Result<()> {
        msg!("Greetings from: {:?}", ctx.program_id);
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize {}
